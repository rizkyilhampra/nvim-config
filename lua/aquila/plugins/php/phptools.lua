return {
    'ccaglak/phptools.nvim',
    keys = {
        {
            "<leader>Lm",
            "<cmd>PhpMethod<cr>",
            desc = "Generate undefined method in class"
        },
        {
            "<leader>Lc",
            "<cmd>PhpClass<cr>",
            desc = "Generate undefined class, trait, interface or enum"
        },
        {
            "<leader>Ls",
            "<cmd>PhpScripts<cr>",
            desc = "Runs composer scripts"
        },
        {
            "<leader>Ln",
            "<cmd>PhpNamespace<cr>",
            desc = "Generate namespace for the current file"
        },
        {
            "<leader>Lg",
            "<cmd>PhpGetSet<cr>",
            desc = "Generate getter and setter for the current class"
        },
        {
            "<leader>Lf",
            "<cmd>PhpCreate<cr>",
            desc = "Create class, interface, enum, or trait in current file"
        },
        {
            "<leader>Lr",
            "<cmd>PhpRefactor<cr>",
            desc = "Refactor the current file",
            mode = "v"
        }
    },
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    lazy = true,
    opts = {
        ui = false, -- if you have stevearc/dressing.nvim or something similar keep it false or else true
    },
    config = true,
    cond = function()
        return vim.fn.isdirectory("vendor") == 1
    end,
}