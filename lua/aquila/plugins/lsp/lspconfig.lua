return {
    "neovim/nvim-lspconfig",
    event = "User BaseFile",
    dependencies = {
        "williamboman/mason.nvim",
        "stevearc/dressing.nvim",
        { "antosha417/nvim-lsp-file-operations", config = true },
        {
            "zeioth/garbage-day.nvim", -- Stop inactive LSP clients to free RAM
            opts = {
                aggressive_mode = false,
                excluded_lsp_clients = {
                    "copilot"
                },
                grace_period = (60 * 15),
                wakeup_delay = 3000,
                notifications = false,
                retries = 3,
                timeout = 1000,
            }
        },
    },
    config = function()
        vim.diagnostic.config(require("aquila.core.global").diagnostics[vim.g.diagnostics_virtual_text])

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local bufnr = event.buf
                local client = vim.lsp.get_client_by_id(event.data.client_id) or {}
                local opts = { noremap = true, silent = true, buffer = bufnr }

                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)      -- see available code actions, in visual mode will apply to selection
                vim.keymap.set("n", "<C-k>", function()
                    vim.diagnostic.open_float()
                end, opts)
                vim.keymap.set("n", "<leader>cd", function()
                    require("aquila.core.commands").toggle_virtual_text_diagnostic()
                end, vim.tbl_deep_extend("force", opts, { desc = "Toggle diagnostic message" }))

                vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

                -- i'm not sure if this is necessary. stole it from https://github.com/pynappo/dotfiles/
                -- vim.b[bufnr].lsp_attached = true
                -- if not client then return end
                -- if vim.tbl_contains({ 'copilot', 'null-ls' }, client.name or vim.print('no client found')) then return end
            end,
        })

        local lspconfig = require("lspconfig")
        local capabilities = vim.tbl_deep_extend("force",
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )
        capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

        lspconfig.intelephense.setup({
            capabilities = capabilities,
        })

        -- TODO: See if https://github.com/phpactor/phpactor/issues/2394 has closed or there is new update
        --
        -- lspconfig.phpactor.setup({
        --     capabilities = capabilities,
        --     init_options = {
        --         ["language_server_worse_reflection.inlay_hints.enable"] = true,
        --         ['language_server_phpstan.enabled'] = true,
        --         ["phpunit.enabled"] = true,
        --     },
        --     root_dir = function(fname)
        --         return lspconfig.util.root_pattern("composer.json", ".git")(fname) or lspconfig.util.path.dirname(fname)
        --     end,
        -- })

        -- Lua Language Server
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        pathStrict = true,
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("lua")] = true,
                            [vim.fn.expand("${3rd}/luv/library")] = true,
                            -- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        },
                    },
                    hint = {
                        enable = true,
                        -- setType = false,
                        arrayIndex = "Disable",
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                    -- checkThirdParty = false,
                    -- telemetry = {
                    --     enable = true,
                    -- },
                },
            },
        })

        -- CSS Language Server
        lspconfig.cssls.setup({
            capabilities = capabilities,
        })

        -- HTML Language Server
        lspconfig.html.setup({
            capabilities = capabilities,
            filetypes = { "html", "blade" },
        })

        lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = {
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "svelte",
                "pug",
                "typescriptreact",
                "vue",
                "blade",
            },
        })

        -- Bash Language Server
        lspconfig.bashls.setup({
            capabilities = capabilities,
            single_file_support = true,
        })

        lspconfig.jsonls.setup({
            capabilities = capabilities,
        })

        lspconfig.marksman.setup({
            capabilities = capabilities,
        })

        lspconfig.typos_lsp.setup({
            capabilities = capabilities,
            init_options = {
                -- config = "--exclude *;#toggleterm#1 ",
                diagnosticSeverity = "Hint"
            },
            autostart = false
        })

        lspconfig.docker_compose_language_service.setup({
            capabilities = capabilities
        })

        lspconfig.dockerls.setup({
            capabilities = capabilities
        })

        lspconfig.vtsls.setup({
            capabilities = capabilities
        })
    end,
}