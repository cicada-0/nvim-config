-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({})
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    { "EdenEast/nightfox.nvim", lazy = true },  -- available if you want to switch
}
