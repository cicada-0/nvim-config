-- ~/.config/nvim/lua/plugins/lsp.lua
return {
    -- Mason: package manager for LSP servers
    {
        "mason-org/mason.nvim",
        opts = {
            ui = { border = "rounded" },
        },
    },

    -- Bridge: auto-install and auto-enable servers
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "pyright", "rust_analyzer", "lua_ls" },
                automatic_enable = true,
            })

            -- ── clangd (C/C++) ──
            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                root_markers = {
                    "compile_commands.json", "compile_flags.txt",
                    ".clangd", "Makefile", "CMakeLists.txt", ".git",
                },
                capabilities = {
                    offsetEncoding = { "utf-16" },
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
            })

            -- ── lua_ls (for nvim config editing) ──
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            -- ── rust_analyzer ──
            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        check = {
                            command = "clippy",        -- use clippy instead of cargo check
                            extraArgs = { "--no-deps" },
                        },
                        procMacro = { enable = true },
                    },
                },
            })

            -- pyright uses defaults — nothing to customize
        end,
    },

    -- nvim-lspconfig: provides default LSP configs
    { "neovim/nvim-lspconfig" },

    -- Diagnostics display config (not a plugin, but best place for it)
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.diagnostic.config({
                virtual_text = { prefix = "●", spacing = 4 },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = { border = "rounded", source = true },
            })
        end,
    },
}
