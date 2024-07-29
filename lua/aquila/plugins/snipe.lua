return {
    "leath-dub/snipe.nvim",
    event = "User BaseFile",
    config = function()
        local snipe = require("snipe")
        snipe.setup()
        vim.keymap.set("n", "gb", snipe.create_buffer_menu_toggler())
    end
}