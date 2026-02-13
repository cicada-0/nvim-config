-- ~/.config/nvim/lua/config/opts.lua
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = true
-- opt.colorcolumn = "100"

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- File handling
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Clipboard
opt.clipboard = "unnamedplus"

-- Whitespace display
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Mouse
opt.mouse = "a"
