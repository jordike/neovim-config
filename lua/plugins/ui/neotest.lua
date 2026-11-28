return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',

        -- Test adapters
        'nvim-neotest/neotest-python',
        'haydenmeade/neotest-jest',
        'marilari88/neotest-vitest',
        'sidlatau/neotest-dart',
        'V13Axel/neotest-pest',
        'Issafalcon/neotest-dotnet',
        'rcasia/neotest-java',
        'codymikol/neotest-kotlin',
        'alfaix/neotest-gtest',
        'orjangj/neotest-ctest',
        'hoxbro/neotest-rust',
    },
    cmd = {
        'Neotest',
    },
    config = function()
        local lib = require('neotest.lib')
        lib.files.sep = '/'

        local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'

        -- Some plugins return native backslash paths on Windows. Normalise
        -- them before Neotest's separator-aware helpers split them.
        local files_parent = lib.files.parent
        lib.files.parent = function(path)
            if path and path:find('\\', 1, true) then
                path = path:gsub('\\', '/')
            end
            return files_parent(path)
        end

        -- Keep discovery in the main process. Neotest's child process does not
        -- load user config, so it would miss the Windows/Neovim fixes below.
        lib.subprocess.enabled = function()
            return false
        end
        lib.subprocess.init = function() end

        -- :Neotest run resolves the current file with expand('%:p'), which
        -- still returns backslashes on Windows. Normalize it so the nearest
        -- test can be found. No-op on other platforms.
        local nio = require('nio')
        local expand = nio.fn.expand
        nio.fn.expand = function(expr, ...)
            local result = expand(expr, ...)
            if is_windows and type(result) == 'string' and expr == '%:p' then
                return result:gsub('\\', '/')
            end
            return result
        end

        -- neotest-gtest encodes project paths as storage file names. Escape
        -- forward slashes and the drive colon so the JSON file can be created
        -- on Windows. Harmless elsewhere.
        local gtest_utils = require('neotest-gtest.utils')
        local encode_path = gtest_utils.encode_path
        gtest_utils.encode_path = function(path)
            local encoded = encode_path(path)
            if is_windows then
                encoded = encoded:gsub('/', '%%0'):gsub('^(%a):', '%1_')
            end
            return encoded
        end

        -- Java and Kotlin share Gradle/Maven build files, so markers alone
        -- cannot tell them apart.
        local java_markers = {
            'pom.xml', 'settings.gradle', 'settings.gradle.kts',
            'build.gradle', 'build.gradle.kts', 'mvnw', 'gradlew',
        }

        -- Only start an adapter when the project actually contains its
        -- markers. Without this, adapters with loose filename patterns (e.g.
        -- *Test) claim files from unrelated languages.
        local markers_by_adapter = {
            ['neotest-python'] = {
                'pyproject.toml', 'setup.py', 'setup.cfg', 'pytest.ini',
                'tox.ini', 'mypy.ini', 'requirements.txt', 'Pipfile',
            },
            ['neotest-jest'] = {
                'package.json', 'jest.config.js', 'jest.config.ts', 'jest.config.mjs',
            },
            ['neotest-vitest'] = {
                'package.json', 'vite.config.js', 'vite.config.ts',
                'vitest.config.js', 'vitest.config.ts',
            },
            ['neotest-dart'] = { 'pubspec.yaml' },
            ['neotest-pest'] = { 'composer.json', 'phpunit.xml' },
            ['neotest-dotnet'] = { '*.sln', '*.csproj', '*.fsproj', 'global.json' },
            ['neotest-java'] = java_markers,
            ['neotest-kotlin'] = {
                'pom.xml', 'settings.gradle', 'settings.gradle.kts',
                'build.gradle', 'build.gradle.kts', 'mvnw', 'gradlew',
            },
            ['neotest-gtest'] = {
                'CMakeLists.txt', 'compile_commands.json', 'compile_flags.txt', '.clangd',
            },
            ['neotest-ctest'] = {
                'CMakeLists.txt', 'CMakePresets.json', 'compile_commands.json',
                'CTestTestfile.cmake',
            },
            ['neotest-rust'] = { 'Cargo.toml' },
        }

        -- Adapters whose filename patterns are loose enough to match files
        -- from other languages need their marker check applied to is_test_file
        -- as well as root.
        local gate_files_by_adapter = {
            ['neotest-java'] = true,
        }

        local marker_cache = {}
        local function has_marker(path, markers)
            path = path:gsub('\\', '/')
            local dir = lib.files.is_dir(path) and path or lib.files.parent(path)
            for _, marker in ipairs(markers) do
                local key = dir .. '\0' .. marker
                if marker_cache[key] == nil then
                    marker_cache[key] = lib.files.match_root_pattern(marker)(dir) ~= nil
                end
                if marker_cache[key] then
                    return true
                end
            end
            return false
        end

        local function marker_root(path, markers)
            path = path:gsub('\\', '/')
            for _, marker in ipairs(markers) do
                local root = lib.files.match_root_pattern(marker)(path)
                if root then
                    return root
                end
            end
        end

        -- Shared build files are not enough to identify the language. Require
        -- at least one real source file of the adapter's language, ignoring
        -- generated sources in common build directories.
        local source_extension_by_adapter = {
            ['neotest-java'] = 'java',
            ['neotest-kotlin'] = 'kt',
            ['neotest-rust'] = 'rs',
        }
        local file_extension_by_adapter = {
            ['neotest-java'] = '%.java$',
            ['neotest-kotlin'] = '%.kt$',
            ['neotest-rust'] = '%.rs$',
        }
        local project_source_cache = {}
        local function has_project_source(path, markers, ext)
            local normalized = (path or ''):gsub('\\', '/')
            local dir = lib.files.is_dir(normalized) and normalized or lib.files.parent(normalized)
            local project_root = marker_root(dir, markers) or dir
            if not project_root or project_root == '' then
                return false
            end
            local key = project_root .. '\0' .. ext
            if project_source_cache[key] then
                return true
            end
            local files = vim.fn.globpath(project_root, '**/*.' .. ext, false, true)
            for _, file in ipairs(files) do
                local candidate = file:gsub('\\', '/'):lower()
                if not (candidate:find('/build/')
                    or candidate:find('/target/')
                    or candidate:find('/out/')
                    or candidate:find('/.gradle/')
                    or candidate:find('^build/')
                    or candidate:find('^target/'))
                then
                    project_source_cache[key] = true
                    return true
                end
            end
            return false
        end

        -- CMakeLists.txt alone does not mean CTest is used. Require actual CTest
        -- registration or a generated CTest file so CTest does not claim plain
        -- GoogleTest projects.
        local ctest_gate_cache = {}
        local function has_ctest_registration(path, markers)
            local normalized = (path or ''):gsub('\\', '/')
            local dir = lib.files.is_dir(normalized) and normalized or lib.files.parent(normalized)
            local root = marker_root(dir, markers) or dir
            if not root or root == '' then
                return false
            end
            if ctest_gate_cache[root] ~= nil then
                return ctest_gate_cache[root]
            end

            local found = false
            for _, pattern in ipairs({
                'CTestTestfile.cmake',
                '**/CTestTestfile.cmake',
                'CMakeLists.txt',
                '**/CMakeLists.txt',
            }) do
                for _, file in ipairs(vim.fn.globpath(root, pattern, false, true)) do
                    if file:match('CTestTestfile%.cmake$') then
                        found = true
                        break
                    end
                    local content = table.concat(vim.fn.readfile(file, ''), '\n')
                    if content:find('add_test%s*%(')
                        or content:find('enable_testing%s*%(')
                        or content:find('include%s*%(%s*CTest%s*%)')
                    then
                        found = true
                        break
                    end
                end
                if found then
                    break
                end
            end

            ctest_gate_cache[root] = found
            return found
        end

        local extra_root_gates_by_adapter = {
            ['neotest-ctest'] = has_ctest_registration,
        }

        -- Neotest position IDs use forward slashes after the separator fix
        -- above, but some adapters (e.g. neotest-python's pytest plugin) build
        -- result IDs with native Windows paths. Normalise both streamed and
        -- final results so they match the discovered positions.
        local function normalise_result_keys(results)
            if not is_windows or type(results) ~= 'table' then
                return results
            end
            local normalised = {}
            for id, result in pairs(results) do
                normalised[id:gsub('\\', '/')] = result
            end
            return normalised
        end

        -- neotest-jest passes an escaped absolute Windows path as Jest's
        -- testPathPattern, which does not match Jest's own paths. Use a
        -- relative path instead.
        local function fix_jest_path(spec, position_path)
            if not is_windows or not spec or type(spec.command) ~= 'table' then
                return
            end
            local cwd = spec.cwd or vim.loop.cwd()
            local relative = vim.fs.relpath(cwd, position_path)
            if not relative then
                return
            end
            relative = relative:gsub('\\', '/')
            local basename = vim.fn.fnamemodify(position_path, ':t')
            for i = #spec.command, 1, -1 do
                local arg = spec.command[i]
                if type(arg) == 'string'
                    and not arg:match('^%-')
                    and arg:find(basename, 1, true)
                then
                    spec.command[i] = relative
                    return
                end
            end
        end

        local function wrap_result_normalisation(adapter, name)
            local build_spec = adapter.build_spec
            if build_spec then
                adapter.build_spec = function(...)
                    local args = select(1, ...)
                    local spec = build_spec(...)
                    if name == 'neotest-jest' and args and args.tree then
                        fix_jest_path(spec, args.tree:data().path)
                    end
                    if spec and type(spec.stream) == 'function' then
                        local stream = spec.stream
                        spec.stream = function(output)
                            local next_results = stream(output)
                            return function()
                                local results = next_results()
                                if results then
                                    return normalise_result_keys(results)
                                end
                            end
                        end
                    end
                    return spec
                end
            end
            local results = adapter.results
            if results then
                adapter.results = function(...)
                    return normalise_result_keys(results(...))
                end
            end
            return adapter
        end

        local function relevant(adapter, name, markers, gate_files)
            wrap_result_normalisation(adapter, name)
            if not markers then
                return adapter
            end
            local root = adapter.root
            local is_test_file = adapter.is_test_file
            local source_ext = source_extension_by_adapter[name]
            local file_pattern = file_extension_by_adapter[name]
            local extra_root_gate = extra_root_gates_by_adapter[name]

            local function project_matches(path)
                if not path or not has_marker(path, markers) then
                    return false
                end
                if source_ext and not has_project_source(path, markers, source_ext) then
                    return false
                end
                if extra_root_gate and not extra_root_gate(path, markers) then
                    return false
                end
                return true
            end

            adapter.root = function(path)
                if not project_matches(path) then
                    return nil
                end
                local resolved = root(path) or marker_root(path, markers)
                if is_windows and type(resolved) == 'string' then
                    resolved = resolved:gsub('\\', '/')
                end
                return resolved
            end
            if gate_files or file_pattern then
                adapter.is_test_file = function(path)
                    if not project_matches(path) then
                        return false
                    end
                    if file_pattern
                        and not path:gsub('\\', '/'):match(file_pattern)
                    then
                        return false
                    end
                    return is_test_file(path)
                end
            end
            return adapter
        end

        local function adapter(name, configured)
            return relevant(
                configured or require(name),
                name,
                markers_by_adapter[name],
                gate_files_by_adapter[name]
            )
        end

        -- neotest-dotnet detects the test framework with an old-style
        -- Tree-sitter iter_matches call that fails on newer Neovim builds.
        -- Detect the framework from attributes instead so discovery and
        -- result parsing still work.
        local function dotnet_adapter()
            -- Neovim calls the C# filetype "cs" but the parser is "c_sharp".
            if vim.treesitter.language.register then
                vim.treesitter.language.register('c_sharp', 'cs')
            end

            local discovery = require('neotest-dotnet.framework-discovery')
            if discovery._neotest_compat then
                return require('neotest-dotnet')
            end
            discovery._neotest_compat = true

            local frameworks = {
                xunit = require('neotest-dotnet.xunit'),
                mstest = require('neotest-dotnet.mstest'),
                nunit = require('neotest-dotnet.nunit'),
            }
            local attributes = {
                xunit = { 'Fact', 'Theory' },
                mstest = { 'TestMethod', 'DataTestMethod' },
                nunit = { 'Test', 'TestCase', 'TestCaseSource' },
            }

            discovery.get_test_framework_utils_from_source = function(source, custom)
                for _, framework in ipairs({ 'xunit', 'mstest', 'nunit' }) do
                    local names = vim.list_extend({}, attributes[framework])
                    if custom and custom[framework] then
                        vim.list_extend(names, custom[framework])
                    end
                    for _, name in ipairs(names) do
                        if source:find('%[%s*[%w%.]*' .. name, 1) then
                            return frameworks[framework]
                        end
                    end
                end
                return frameworks.xunit
            end

            return require('neotest-dotnet')
        end

        -- neotest-java treats a bare .git directory as a valid root and its
        -- *Test filename pattern also matches C++ files. Require a real Java
        -- build file so it only appears in Java projects.
        local java_root_finder = {
            find_root = function(dir)
                for _, marker in ipairs({
                    'pom.xml',
                    'settings.gradle',
                    'settings.gradle.kts',
                    'build.gradle',
                    'build.gradle.kts',
                    'mvnw',
                    'gradlew',
                }) do
                    local root = lib.files.match_root_pattern(marker)(dir)
                    if root then
                        return root
                    end
                end
            end,
        }
        local java = require('neotest-java')({}, { root_finder = java_root_finder })

        -- neotest-gtest only matches test_*.<cpp>|*_test.<cpp> by default.
        -- Keep those, and also accept *Test.cpp plus files under tests/.
        local gtest = require('neotest-gtest').setup({
            root = lib.files.match_root_pattern(
                'CMakeLists.txt',
                'compile_commands.json',
                'compile_flags.txt',
                '.clangd',
                '.git'
            ),
            is_test_file = function(path)
                local normalized = path:gsub('\\', '/')
                local ext = normalized:match('%.(%w+)$')
                local cpp_ext = ext == 'cpp' or ext == 'cc' or ext == 'cxx'
                    or ext == 'c++' or ext == 'cppm'
                if not cpp_ext then
                    return false
                end
                if normalized:lower():match('/tests?/') then
                    return true
                end
                local name = vim.fs.basename(normalized)
                return name:match('^test_') ~= nil
                    or name:match('_test%.') ~= nil
                    or name:match('Test%.') ~= nil
            end,
            mappings = { configure = 'C' },
        })

        require('neotest').setup({
            adapters = {
                adapter('neotest-python'),
                -- Vitest must come before Jest. Jest claims any *.test.* file,
                -- while Vitest also checks for a vitest dependency.
                adapter('neotest-vitest'),
                adapter('neotest-jest'),
                adapter('neotest-dart'),
                adapter('neotest-pest'),
                adapter('neotest-dotnet', dotnet_adapter()),
                adapter('neotest-java', java),
                adapter('neotest-kotlin'),
                adapter('neotest-gtest', gtest),
                adapter('neotest-ctest'),
                adapter('neotest-rust'),
            },
            output_panel = { open_on_run = true },
            diagnostic = { enabled = true },
        })
    end,
    keys = {
        {
            '<leader>nts',
            function()
                require('neotest').summary.toggle()
            end,
            desc = 'Toggle Neotest summary',
            silent = true,
        },
        {
            '<leader>ntr',
            function()
                require('neotest').run.run()
            end,
            desc = 'Run Neotest tests',
            silent = true,
        },
        {
            '<leader>nta',
            function()
                require('neotest').run.run(vim.fn.getcwd())
            end,
            desc = 'Run all Neotest tests',
            silent = true,
        },
    },
}
