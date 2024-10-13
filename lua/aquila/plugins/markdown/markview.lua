return {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local presets = require("markview.presets")

        require("markview").setup({
            hybrid_modes = { "n" },
            checkboxes = presets.checkboxes.nerd,
        });

        require("markview.extras.editor").setup({
            width = { 50, 0.75 },
            height = { 20, 0.75 },
            debounce = 50,
        });
    end
}