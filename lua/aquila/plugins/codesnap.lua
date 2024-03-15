return {
    "mistricky/codesnap.nvim",
    build = "make",
    event = "BufReadPost",
    config = function()
        require("codesnap").setup({
            watermark = "",
            editor_font_familiy = "GeistMono Nerd Font"
        })
    end
}