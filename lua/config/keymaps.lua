-- ~/.config/nvim/lua/config/keymaps.lua
local map = vim.keymap.set

-- ── Window navigation ──
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- ── Resize windows ──
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- ── Buffer navigation ──
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- ── Move lines in visual mode ──
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── Stay centered ──
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- ── Better paste ──
map("x", "<leader>p", '"_dP', { desc = "Paste without losing register" })

-- ── Misc ──
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- ── Diagnostics ──
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

-- ── File explorer ──
map("n", "<leader>e", ":NvimTreeToggle<cr>", { silent = true, desc = "Toggle explorer" })

-- ── Git ──
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- ── C/C++ header switch ──
map("n", "<leader>gh", "<cmd>LspClangdSwitchSourceHeader<cr>", { desc = "Switch Source/Header" })

-- ── Build (C++) ──
map("n", "<leader>cc", function()
    vim.cmd("write")
    -- Ensure toggleterm is loaded before using TermExec
    require("toggleterm")
    if vim.fn.filereadable("Makefile") == 1 then
        vim.cmd("TermExec cmd='make'")
    else
        local file = vim.fn.expand("%")
        local out = vim.fn.expand("%<")
        vim.cmd("TermExec cmd='g++ " .. file .. " -o " .. out .. " && ./" .. out .. "'")
    end
end, { desc = "Compile and Run C++" })

map("n", "<leader>cg", ":CMakeGenerate<cr>", { desc = "CMake Generate" })
map("n", "<leader>cb", ":CMakeBuild<cr>", { desc = "CMake Build" })
map("n", "<leader>cr", ":CMakeRun<cr>", { desc = "CMake Run" })

-- ── LSP keymaps (set when a server attaches) ──
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_keymaps", { clear = true }),
    callback = function(event)
        local buf = event.buf
        local o = function(desc)
            return { buffer = buf, desc = "LSP: " .. desc }
        end

        map("n", "gd", vim.lsp.buf.definition, o("Go to Definition"))
        map("n", "gD", vim.lsp.buf.declaration, o("Go to Declaration"))
        map("n", "gi", vim.lsp.buf.implementation, o("Go to Implementation"))
        map("n", "gr", vim.lsp.buf.references, o("Show References"))
        map("n", "gt", vim.lsp.buf.type_definition, o("Type Definition"))
        map("n", "K", vim.lsp.buf.hover, o("Hover Documentation"))
        map("i", "<C-k>", vim.lsp.buf.signature_help, o("Signature Help"))
        map("n", "<leader>rn", vim.lsp.buf.rename, o("Rename Symbol"))
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, o("Code Action"))
        map("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, o("Format File"))
    end,
})

-- ── Terminal keymaps (set when terminal opens) ──
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("user_term_keymaps", { clear = true }),
    pattern = "term://*",
    callback = function()
        local o = { buffer = 0 }
        map("t", "<esc>", [[<C-\><C-n>]], o)
        map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], o)
        map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], o)
        map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], o)
        map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], o)
    end,
})
