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
                "intelephense",
                "lua_ls",
                "cssls",
                "html",
                "tsserver",
                "emmet_ls",
                "bashls"
            },
            automatic_installation = true
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "eslint_d",
                "prettierd"
            }
        })
    end
}
