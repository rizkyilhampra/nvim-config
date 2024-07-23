return {
    'b0o/incline.nvim',
    event = 'User BaseFile',
    enabled = true,
    config = function()
        local helpers = require 'incline.helpers'
        local devicons = require 'nvim-web-devicons'

        require('incline').setup {
            window = {
                padding = 0,
                margin = {
                    horizontal = 0,
                },
            },
            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                if filename == '' then
                    filename = '[No Name]'
                end
                local ft_icon, ft_color = devicons.get_icon_color(filename)
                if ft_icon == nil then
                    ft_icon = ''
                    ft_color = '#ffffff'
                end
                local modified = vim.bo[props.buf].modified

                return {
                    {
                        '',
                        guibg = nil,
                        guifg = ft_color,
                    },
                    ft_icon and
                    { ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
                    or ' ',
                    {
                        ' ',
                        guibg = require("tokyonight.util").blend_bg(ft_color, 0.8),
                        guifg = helpers.contrast_color(ft_color),
                        {
                            filename,
                            gui = modified and 'bold,italic' or 'normal'
                        },
                        ' '
                    },
                }
            end,
        }
    end,
}