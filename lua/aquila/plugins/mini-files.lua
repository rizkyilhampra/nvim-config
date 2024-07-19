return {
    'echasnovski/mini.files',
    version = false,
    opts = {},
    keys = {
        {
            "<Leader>E",
            function()
                local MiniFiles = require('mini.files')

                if not MiniFiles.close() then MiniFiles.open() end
            end,
            desc = "Toggle MiniFiles"
        }
    }
}