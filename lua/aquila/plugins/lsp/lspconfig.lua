return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "folke/neodev.nvim",
    },
    config = function()
        require('neodev').setup();

        local lspconfig = require("lspconfig")

        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
            vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
            vim.keymap.set("n", "gd", '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)      -- see available code actions, in visual mode will apply to selection
            vim.keymap.set("n", '<c-k>', function()
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

            if client and client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(bufnr, true)
            end
        end

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- PHP language server (PHPActor)
        lspconfig.phpactor.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = function(fname)
                return lspconfig.util.root_pattern("composer.json", ".git")(fname) or lspconfig.util.path.dirname(fname)
            end,
        })

        -- Lua Language Server
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    }
                },
            }
        })

        -- CSS Language Server
        lspconfig.cssls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- HTML Language Server
        lspconfig.html.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "blade" },
        })

        -- Javascript and Typescript Language Server
        lspconfig.tsserver.setup({
            capabilities = capabilities,
            on_attach = on_attach,
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
            on_attach = on_attach
        })

        local global = require("aquila.core.global")

        vim.diagnostic.config {
            virtual_text = false,
            -- virtual_text = {
            --     virt_text_hide = true,
            --     spacing = 4,
            --     prefix = "● ",
            --     severity = vim.diagnostic.severity.ERROR,
            -- },
            float = {
                severity_sort = true,
                source = "if_many",
            },
            severity_sort = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = global.icons.diagnostic.error,
                    [vim.diagnostic.severity.WARN] = global.icons.diagnostic.warn,
                    [vim.diagnostic.severity.HINT] = global.icons.diagnostic.hint,
                    [vim.diagnostic.severity.INFO] = global.icons.diagnostic.info,
                },
            },
        }
    end
}
