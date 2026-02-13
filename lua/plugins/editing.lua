-- ~/.config/nvim/lua/plugins/editing.lua
return {
    -- Auto pairs
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = { check_ts = true } },

    -- Surround (cs"' to change " to ', ysiw] to surround word, etc.)
    { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },

    -- Comment toggling (gcc for line, gc in visual)
    { "numToStr/Comment.nvim", event = { "BufReadPost", "BufNewFile" }, opts = {} },

    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
        },
        opts = {
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_terminals = true,
            direction = "float",
            float_opts = { border = "curved" },
        },
    },

    -- LazyGit integration
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "LazyGit",
    },
}
