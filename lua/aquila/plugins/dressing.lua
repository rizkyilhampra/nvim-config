return {
    'stevearc/dressing.nvim',
    opts = {},
    config = function()
        require('dressing').setup({
            select = {
                get_config = function(opts)
                    if opts.kind == 'codeaction' then
                        return {
                            backend = 'nui',
                            nui = {
                                max_width = 40,
                            }
                        }
                    end
                end
            }
        })
    end
}
