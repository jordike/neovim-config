local function fallback()
    local stem = vim.fn.expand('%:t:r')
    local ext = vim.fn.expand('%:e'):lower()
    local is_header = vim.tbl_contains({ 'h', 'hpp', 'hh', 'hxx', 'h++' }, ext)
    local targets = is_header and { 'cpp', 'cc', 'cxx', 'c++', 'c' } or { 'h', 'hpp', 'hh', 'hxx', 'h++' }

    local client = vim.lsp.get_clients({ bufnr = 0 })[1]
    local root = client and client.root_dir or vim.fn.getcwd()
    local current = vim.fs.dirname(vim.api.nvim_buf_get_name(0))

    for _, dir in ipairs({ current, vim.fs.joinpath(root, 'include'), root }) do
        local matches = vim.fs.find(function(name)
            return vim.fn.fnamemodify(name, ':t:r') == stem
                and vim.tbl_contains(targets, vim.fn.fnamemodify(name, ':e'):lower())
        end, { path = dir, type = 'file', limit = 1 })

        if matches[1] then
            vim.cmd.edit(vim.fn.fnameescape(matches[1]))
            return
        end
    end

    vim.notify('Alternate: no matching file for ' .. stem, vim.log.levels.WARN)
end

vim.keymap.set('n', '<leader>a', function()
    local clangd
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if client.name:match('^clangd') then
            clangd = client
            break
        end
    end

    if not clangd then
        return fallback()
    end

    clangd:request('textDocument/switchSourceHeader', { uri = vim.uri_from_bufnr(0) }, function(_, result)
        if result and result ~= vim.NIL then
            vim.cmd.edit(vim.fn.fnameescape(vim.uri_to_fname(result)))
        else
            fallback()
        end
    end)
end, { silent = true, desc = 'Switch between header/source' })
