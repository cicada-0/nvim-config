-- ~/.config/nvim/lua/config/lazy.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Every .lua file in lua/plugins/ is auto-loaded as a plugin spec
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = { lazy = false },
    install = { colorscheme = { "gruvbox" } },
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
    ui = { border = "rounded" },
})
