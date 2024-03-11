return {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(details)
                local bufnr = details.buf
                local client = vim.lsp.get_client_by_id(details.data.client_id) or {}
                local opts = { noremap = true, silent = true }

                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(bufnr, true)

                    vim.api.nvim_create_autocmd('InsertEnter', {
                        callback = function() vim.lsp.inlay_hint.enable(bufnr, false) end,
                    })
                    vim.api.nvim_create_autocmd('InsertLeave', {
                        callback = function() vim.lsp.inlay_hint.enable(bufnr, true) end,
                    })
                end

                vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
                vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
                vim.keymap.set("n", "gd", '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)      -- see available code actions, in visual mode will apply to selection
                vim.keymap.set("n", '<C-k>', function()
                    vim.diagnostic.open_float(nil, {
                        focusable = false,
                        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                        border = 'rounded',
                        source = 'if_many',
                        -- source = 'always',
                        prefix = ' ',
                        scope = 'line',
                    })
                end, opts)


                local virtual_text_diagnostics_active = true
                vim.keymap.set("n", "<leader>cd", function()
                    virtual_text_diagnostics_active = not virtual_text_diagnostics_active
                    if virtual_text_diagnostics_active then
                        vim.diagnostic.show(nil, bufnr, nil, { virtual_text = true })
                    else
                        vim.diagnostic.show(nil, bufnr, nil, { virtual_text = false })
                    end
                end, opts)

                -- i'm not sure if this is necessary. stole it from https://github.com/pynappo/dotfiles/
                -- vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
                -- vim.b[bufnr].lsp_attached = true
                -- if not client then return end
                -- if vim.tbl_contains({ 'copilot', 'null-ls' }, client.name or vim.print('no client found')) then return end
            end
        })

        local lspconfig = require("lspconfig")

        local capabilities = {
            capabilities = vim.tbl_deep_extend(
                'force',
                vim.lsp.protocol.make_client_capabilities(),
                require('cmp_nvim_lsp').default_capabilities()
            ),
            flags = { debounce_text_changes = 200 },
        }
        -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- PHP language server
        lspconfig.phpactor.setup({
            capabilities = capabilities,
            init_options = {
                ['language_server_configuration.auto_config'] = false,
                -- i think i will toggle this things if i get some information about it
                ['language_server_worse_reflection.inlay_hints.enable'] = true,
                ['language_server_worse_reflection.inlay_hints.types'] = true,
            },
            root_dir = function(fname)
                -- allow single file support
                return lspconfig.util.root_pattern("composer.json", ".git")(fname) or lspconfig.util.path.dirname(fname)
            end,
        })

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
                        arrayIndex = 'Disable',
                    },
                    completion = {
                        callSnippet = "Replace"
                    },
                    -- checkThirdParty = false,
                    -- telemetry = {
                    --     enable = true,
                    -- },
                },
            }
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

        -- Javascript and Typescript Language Server
        lspconfig.tsserver.setup({
            capabilities = capabilities,
        })

        -- Emmet Language Server
        lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte",
                "pug", "typescriptreact", "vue", "blade" },
        })

        -- Bash Language Server
        lspconfig.bashls.setup({
            capabilities = capabilities,
        })

        lspconfig.eslint.setup({
            capabilities = capabilities,
        })

        local global = require("aquila.core.global")

        vim.diagnostic.config({
            update_in_insert = false,
            -- virtual_text = false,
            virtual_text = {
                spacing = 4,
                prefix = "● ",
                source = false
            },
            float = {
                severity_sort = true,
                source = true,
            },
            severity_sort = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = global.icons.diagnostic.error,
                    [vim.diagnostic.severity.WARN] = global.icons.diagnostic.warn,
                    [vim.diagnostic.severity.HINT] = global.icons.diagnostic.hint,
                    [vim.diagnostic.severity.INFO] = global.icons.diagnostic.info,
                },
            }
        })
    end
}
