return {
    "anuvyklack/fold-preview.nvim",
    dependencies = { "anuvyklack/keymap-amend.nvim" },
    event = "BufReadPost",
    opts = {
        border = "single"
    },
    config = function(_, opts)
        require('fold-preview').setup(opts)
    end
}
