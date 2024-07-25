return {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat" },
    dependencies = {
        -- Optional, but highly recommended if you want to use the "Default" timer
        "rcarriga/nvim-notify",
        'nvim-telescope/telescope.nvim',
        'nvim-lualine/lualine.nvim',
        "folke/noice.nvim",
    },
    opts = {},
    keys = {
        {
            '<Leader>ft',
            function()
                require('telescope').extensions.pomodori.timers()
            end,
            desc = "List of timers"

        }
    },
    config = function(_, opts)
        require('pomo').setup(opts)

        local lualine = require('lualine')
        lualine.setup({
            sections = {
                lualine_x = {
                    function()
                        local ok, pomo = pcall(require, "pomo")
                        if not ok then
                            return ""
                        end

                        local timer = pomo.get_first_to_finish()
                        if timer == nil then
                            return ""
                        end

                        return "󰄉 " .. tostring(timer)
                    end,
                    {
                        require("noice").api.status.mode.get,
                        cond = require("noice").api.status.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        require("noice").api.status.search.get,
                        cond = require("noice").api.status.search.has,
                        color = { fg = "#ff9e64" },
                    },
                    'filetype',
                    {
                        'o:encoding',
                        fmt = string.upper,
                    },
                    {
                        'fileformat',
                        symbols = {
                            unix = 'LF',
                            dos = 'CRLF',
                            mac = 'CR',
                        },
                        fmt = string.upper,
                    },
                },
            }

        })
    end
}