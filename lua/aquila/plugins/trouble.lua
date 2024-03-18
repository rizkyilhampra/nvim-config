return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    opts = {},
    keys = {
        {
            "<leader>xx",
            function()
                require('trouble').toggle()
            end,
            desc = "Toggle"
        },
        {
            "<leader>xw",
            function()
                require('trouble').toggle("workspace_diagnostics")
            end,
            desc = "Workspace diagnostics"
        },
        {
            "<leader>xd",
            function()
                require('trouble').toggle("document_diagnostics")
            end,
            desc = "Document diagnostics"
        },
        {
            "<leader>xq",
            function()
                require('trouble').toggle('quickfix')
            end,
            desc = "Quickfix"
        },
        {
            "<leader>xl",
            function() require('trouble').toggle("loclist") end,
            desc = "Loclist"
        }
    },
}