-- ~/.config/nvim/lua/plugins/colorscheme.lua

local theme_file = vim.fn.stdpath("data") .. "/user_theme.txt"

-- Read saved theme, fallback to gruvbox
local function get_saved_theme()
    local f = io.open(theme_file, "r")
    if f then
        local theme = f:read("*l")
        f:close()
        if theme and theme ~= "" then return theme end
    end
    return "gruvbox"
end

-- Save theme to file
local function save_theme(name)
    local f = io.open(theme_file, "w")
    if f then
        f:write(name)
        f:close()
    end
end

-- Apply theme + save it
local function set_theme(name)
    local ok, _ = pcall(vim.cmd.colorscheme, name)
    if ok then
        save_theme(name)
        vim.notify("Theme: " .. name, vim.log.levels.INFO)
    else
        vim.notify("Theme not found: " .. name, vim.log.levels.ERROR)
    end
end

-- Expose globally so keymap can use it
_G.set_theme = set_theme

-- Apply saved theme after all plugins load
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
        local theme = get_saved_theme()
        pcall(vim.cmd.colorscheme, theme)
    end,
})

return {
    -- All themes loaded eagerly (lazy = false) so they appear in Telescope picker

    -- ── Gruvbox ──
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({ contrast = "hard" })
            -- Apply on first load (LazyDone autocmd handles subsequent opens)
            pcall(vim.cmd.colorscheme, get_saved_theme())
        end,
    },

    -- ── Nightfox family: nightfox, duskfox, nordfox, terafox, carbonfox ──
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        config = function()
            require("nightfox").setup({})
        end,
    },

    -- ── Catppuccin: catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha ──
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({ flavour = "mocha" })
        end,
    },

    -- ── Tokyonight: tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon ──
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({ style = "night" })
        end,
    },

    -- ── Kanagawa: kanagawa, kanagawa-wave, kanagawa-dragon, kanagawa-lotus ──
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            require("kanagawa").setup({})
        end,
    },

    -- ── Rose Pine: rose-pine-main, rose-pine-moon, rose-pine-dawn ──
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            require("rose-pine").setup({})
        end,
    },

    -- ── OneDark: onedark ──
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
            require("onedark").setup({ style = "dark" })
        end,
    },
}
