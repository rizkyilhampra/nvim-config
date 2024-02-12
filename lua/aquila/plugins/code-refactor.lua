-- code actions that do not require a language server. It integrates with treesitter and offers various actions for JavaScript and PHP code. It allows toggling arrow functions, flipping ternary expressions, negating expressions, and more.
return {
    "jdrupal-dev/code-refactor.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
        { "<leader>cca", "<cmd>CodeActions all<CR>", desc = "Show code-refactor.nvim (not LSP code actions)" },
    },
    event = "BufRead",
    config = function()
        require("code-refactor").setup({
            -- Configuration here, or leave empty to use defaults.
        })
    end
}
