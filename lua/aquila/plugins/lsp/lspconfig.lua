return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
            -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)                  -- go to declaration
            vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)     -- show lsp definitions
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lspconfig.intelephense.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "intelephense", "--stdio" },
            filetypes = { "php" },
            root_dir = function(fname)
                return vim.loop.cwd()
            end,
        })

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach
        })

        lspconfig.cssls.setup({
            capabilities = capabilities,
            on_attach = on_attach
        })

        lspconfig.html.setup({
            capabilities = capabilities,
            on_attach = on_attach
        })

        lspconfig.tsserver.setup({
            capabilities = capabilities,
            on_attach = on_attach
        })

        lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "emmet-ls", "--stdio" },
            filetypes = { "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass",
                "scss", "svelte", "typescriptreact", "vue" },
            root_dir = function(fname)
                return vim.loop.cwd()
            end,
            single_file_support = true
        })
    end
}
