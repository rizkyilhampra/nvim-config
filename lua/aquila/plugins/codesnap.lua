return {
    "mistricky/codesnap.nvim",
    build = "make",
    event = "BufReadPost",
    config = function()
        require("codesnap").setup({
            watermark = "",
            editor_font_familiy = "Iosevka Expanded",
            bg_padding = 0
        })
    end
}