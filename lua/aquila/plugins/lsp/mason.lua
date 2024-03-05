return {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim"
    },
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                },
                border = "single"
            }
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "phpactor",
                "lua_ls",
                "cssls",
                "html",
                "tsserver",
                "emmet_ls",
                "bashls",
                "marksman"
            },
            automatic_installation = true
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "eslint-lsp",
                "prettierd",
                "tailwindcss-language-server",
            }
        })

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MasonToolsStartingInstall',
            callback = function()
                vim.schedule(function()
                    print 'mason-tool-installer is starting'
                end)
            end,
        })
    end
}
