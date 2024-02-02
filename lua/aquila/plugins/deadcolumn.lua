return {
    'Bekaboo/deadcolumn.nvim',
    event = 'BufRead',
    opts = {
        ---@type string|fun(): integer
        scope = 'visible',
        ---@type string[]|fun(mode: string): boolean
        modes = { 'n', 'i', 'v' },
        -- the example below is equivalent when insert mode only
        -- modes = function(mode)
        --     return mode:find('^[ictRss\x13]') ~= nil
        -- end,
        blending = {
            threshold = 0.75,
            -- colorcode = '#000000',
            hlgroup = { 'lualine_c_normal', 'bg' },
        },
        warning = {
            alpha = 0.4,
            offset = 0,
            -- colorcode = '#FF0000',
            hlgroup = { 'lualine_b_normal', 'bg' },
        },
        extra = {
            ---@type string?
            follow_tw = nil,
        },
    }
}
