-- ~/.config/nvim/lua/plugins/telescope.lua
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>",             desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>",              desc = "Live Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>",                desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",              desc = "Help Tags" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>",               desc = "Recent Files" },
        { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",   desc = "Document Symbols" },
        { "<leader>fd", "<cmd>Telescope diagnostics<cr>",            desc = "Diagnostics" },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>",            desc = "Git Commits" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>",             desc = "Git Status" },
        { "<leader>th", function()
            -- Custom theme picker that saves your choice
            require("telescope.builtin").colorscheme({
                enable_preview = true,
                attach_mappings = function(_, map)
                    local actions = require("telescope.actions")
                    local action_state = require("telescope.actions.state")
                    map("i", "<CR>", function(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        if selection then
                            _G.set_theme(selection.value)
                        end
                    end)
                    return true
                end,
            })
        end,
        desc = "Browse & Save Theme"
      },
    },
    opts = {
        defaults = {
            prompt_prefix = " > ",
            selection_caret = "> ",
            sorting_strategy = "ascending",
            layout_config = {
                horizontal = { prompt_position = "top" },
            },
        },
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        pcall(telescope.load_extension, "fzf")
    end,
}
