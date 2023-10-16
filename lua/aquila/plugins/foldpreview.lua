return {
    -- Folding preview, by default h and l keys are used.
    -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
    -- On second press the preview will be closed and fold will be opened.
    -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
    "anuvyklack/fold-preview.nvim",
    dependencies = { "anuvyklack/keymap-amend.nvim" },
    event = "BufReadPost",
    opts = {
        border = "single"
    },
    fasdf
    config = function(_, opts)
        require('fold-preview').setup(opts)
    end
}
