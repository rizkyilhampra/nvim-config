return {
    "echasnovski/mini.icons",
    event = "User BaseDefered",
    enabled = true,
    opts = {},
    config = function()
        require('mini.icons').setup()
        require("mini.icons").mock_nvim_web_devicons()
    end
}