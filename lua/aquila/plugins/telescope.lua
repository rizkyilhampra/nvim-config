return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        -- { "nvim-telescope/telescope-file-browser.nvim" }
    },
    config = function()
        -- Dont Preview binaries
        local previewers = require("telescope.previewers")
        local Job = require("plenary.job")
        local new_maker = function(filepath, bufnr, opts)
            filepath = vim.fn.expand(filepath)
            Job:new({
                command = "file",
                args = { "--mime-type", "-b", filepath },
                on_exit = function(j)
                    local mime_type = vim.split(j:result()[1], "/")[1]
                    if mime_type == "text" then
                        previewers.buffer_previewer_maker(filepath, bufnr, opts)
                    else
                        vim.schedule(function()
                            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                        end)
                    end
                end
            }):sync()
        end

        local actions = require("telescope.actions")
        require('telescope').setup({
            defaults = {
                buffer_previewer_maker = new_maker,
                mappings = {
                    n = {
                        ['q'] = actions.close
                    }
                },
            },
            extensions = {
                file_browser = {
                    initial_mode = "normal",
                    hijack_netrw = false,
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = {
                            height = 0.8,
                            preview_cutoff = 39,
                            preview_height = 0.3,
                        }
                    }
                }
            }
        })


        require('telescope').load_extension('fzf')
        -- require('telescope').load_extension('file_browser')

    end
}
