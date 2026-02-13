-- ~/.config/nvim/lua/plugins/ui.lua
return {
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            sort_by = "case_sensitive",
            view = { width = 30 },
            renderer = {
                group_empty = true,
                highlight_git = true,
                icons = {
                    show = { file = true, folder = true, folder_arrow = true, git = true },
                },
            },
            filters = { dotfiles = false },
            actions = {
                open_file = { quit_on_open = true },
            },
        },
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        opts = {
            options = {
                theme = "gruvbox",
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },

    -- Git signs in the gutter
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            signs = {
                add          = { text = "│" },
                change       = { text = "│" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },

    -- Notifications
    {
        "rcarriga/nvim-notify",
        config = function()
            local notify = require("notify")
            notify.setup({ timeout = 5000 })
            vim.notify = notify
        end,
    },

    -- Diagnostics list
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        },
        opts = {},
    },

    -- Which-key: shows pending keybinds
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
        },
        keys = {
            { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps" },
        },
    },

    -- LSP progress indicator (bottom-right spinner)
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {},
    },
}
