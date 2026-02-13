-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "lua", "vim", "vimdoc",
                "c", "cpp", "cmake",
                "rust", "toml",
                "python", "javascript",
                "bash", "json", "yaml",
                "markdown", "markdown_inline",
            },
        })
    end,
}
