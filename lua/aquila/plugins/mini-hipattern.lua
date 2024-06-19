return {
    'echasnovski/mini.hipatterns',
    event = { "BufReadPre", "BufNewFile" },
    version = false,
    opts = function()
        local hipatterns = require('mini.hipatterns')

        return {
            highlighters = {
                hex_color = hipatterns.gen_highlighter.hex_color(),
            }
        }
    end
}