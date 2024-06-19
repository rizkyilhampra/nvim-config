return {
    'echasnovski/mini.animate',
    event = "User BaseFile",
    version = false,
    opts = function()
        -- don't use animate when scrolling with the mouse
        local mouse_scrolled = false
        for _, scroll in ipairs { "Up", "Down" } do
            local key = "<ScrollWheel" .. scroll .. ">"
            vim.keymap.set({ "", "i" }, key, function()
                mouse_scrolled = true
                return key
            end, { expr = true })
        end

        local animate = require("mini.animate")
        return {
            open = { enable = false }, -- true causes issues on nvim-spectre
            resize = {
                timing = animate.gen_timing.linear { duration = 33, unit = "total" },
            },
            close = { enable = false },
            scroll = {
                timing = animate.gen_timing.linear { duration = 26, unit = "total" },
                subscroll = animate.gen_subscroll.equal {
                    predicate = function(total_scroll)
                        if mouse_scrolled then
                            mouse_scrolled = false
                            return false
                        end
                        return total_scroll > 1
                    end,
                },
            },
            cursor = {
                enable = false, -- We don't want cursor ghosting
                timing = animate.gen_timing.linear { duration = 26, unit = "total" },
            },
        }
    end,
}