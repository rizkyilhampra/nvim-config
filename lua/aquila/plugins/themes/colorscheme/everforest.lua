return {
    "neanias/everforest-nvim",
    enabled = false,
    config = function()
        require("everforest").setup({
            italics = true,
            background = "hard",
            ui_contrast = "high",
        })
    end,
}
