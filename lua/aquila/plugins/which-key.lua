return {
    "folke/which-key.nvim",
    event = "User BaseDefered",
    opts = {
        disable = { ft = { "TelescopePrompt", "noice", "toggleterm" } },
        icons = {
            mappings = false
        }
    },
    config = function(_, opts)
        require('which-key').setup(opts)

        require('which-key').add({
            { "<Leader>f",  group = "find/file" },
            { "<Leader>fl", group = "lsp" },
            { "<Leader>t",  group = "terminal" },
            { "<Leader>x",  group = "diagnostic" },
            { "<Leader>c",  group = "code" },
            { "<Leader>g",  group = "git" },
            { "<Leader>G",  group = "file tags" },
        })
    end
}