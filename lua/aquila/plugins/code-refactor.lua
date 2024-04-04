-- code actions that do not require a language server. It integrates with treesitter and offers various actions for JavaScript and PHP code. It allows toggling arrow functions, flipping ternary expressions, negating expressions, and more.
return {
    "jdrupal-dev/code-refactor.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
        { "<leader>cc", "<cmd>CodeActions all<CR>", desc = "Refactor" },
    },
    opts = {}
}