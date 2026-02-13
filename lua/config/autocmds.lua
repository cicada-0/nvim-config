-- ~/.config/nvim/lua/config/autocmds.lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
    group = augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 200 })
    end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
    group = augroup("trim_whitespace", { clear = true }),
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
    group = augroup("last_position", { clear = true }),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Format C/C++/Rust on save via LSP
autocmd("BufWritePre", {
    group = augroup("format_on_save", { clear = true }),
    pattern = { "*.c", "*.h", "*.cpp", "*.hpp", "*.cc", "*.cxx", "*.rs" },
    callback = function()
        vim.lsp.buf.format({ async = false, timeout_ms = 3000 })
    end,
})
