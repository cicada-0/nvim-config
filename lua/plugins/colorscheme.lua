-- ~/.config/nvim/lua/plugins/colorscheme.lua

-- ╔══════════════════════════════════════════════════════════╗
-- ║  Change your theme here, or press <leader>th to browse  ║
-- ╚══════════════════════════════════════════════════════════╝
local active_theme = "gruvbox"

return {
    -- ── Gruvbox ──
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        lazy = active_theme ~= "gruvbox",
        config = function()
            require("gruvbox").setup({ contrast = "hard" })
            if active_theme == "gruvbox" then vim.cmd.colorscheme("gruvbox") end
        end,
    },

    -- ── Nightfox family (nightfox, duskfox, nordfox, terafox, carbonfox) ──
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        lazy = not vim.tbl_contains({ "nightfox", "duskfox", "nordfox", "terafox", "carbonfox" }, active_theme),
        config = function()
            require("nightfox").setup({})
            if vim.tbl_contains({ "nightfox", "duskfox", "nordfox", "terafox", "carbonfox" }, active_theme) then
                vim.cmd.colorscheme(active_theme)
            end
        end,
    },

    -- ── Catppuccin (catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha) ──
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = not active_theme:find("catppuccin"),
        config = function()
            require("catppuccin").setup({ flavour = "mocha" })
            if active_theme:find("catppuccin") then vim.cmd.colorscheme(active_theme) end
        end,
    },

    -- ── Tokyonight (tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon) ──
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        lazy = not active_theme:find("tokyonight"),
        config = function()
            require("tokyonight").setup({ style = "night" })
            if active_theme:find("tokyonight") then vim.cmd.colorscheme(active_theme) end
        end,
    },

    -- ── Kanagawa (kanagawa, kanagawa-wave, kanagawa-dragon, kanagawa-lotus) ──
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy = not active_theme:find("kanagawa"),
        config = function()
            require("kanagawa").setup({})
            if active_theme:find("kanagawa") then vim.cmd.colorscheme(active_theme) end
        end,
    },

    -- ── Rose Pine (rose-pine-main, rose-pine-moon, rose-pine-dawn) ──
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        lazy = not active_theme:find("rose%-pine"),
        config = function()
            require("rose-pine").setup({})
            if active_theme:find("rose%-pine") then vim.cmd.colorscheme(active_theme) end
        end,
    },

    -- ── OneDark (dark, darker, cool, deep, warm, warmer) ──
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        lazy = active_theme ~= "onedark",
        config = function()
            require("onedark").setup({ style = "dark" })
            if active_theme == "onedark" then require("onedark").load() end
        end,
    },
}
