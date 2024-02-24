return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        require('neodev').setup();

        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
            vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
            vim.keymap.set("n", "gd", '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)      -- see available code actions, in visual mode will apply to selection
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- PHP language server (PHPActor)
        lspconfig.phpactor.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            init_options = {
                ["language_server_phpstan.enabled"] = false,
                ["language_server_psalm.enabled"] = false,
            },
            single_file_support = true,
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

        vim.diagnostic.config({
            virtual_text = false,
            float = {
                source = true,
            }
        })
    end
}
