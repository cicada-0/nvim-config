-- ~/.config/nvim/init.lua
-- Leader MUST be set before lazy.nvim loads any plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core config
require("config.opts")      -- editor options
require("config.keymaps")   -- key bindings
require("config.autocmds")  -- autocommands
require("config.lazy")      -- bootstrap lazy.nvim + load plugins
