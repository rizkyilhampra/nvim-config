return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        { 'kkharji/sqlite.lua',           module = 'sqlite' },
        { 'nvim-telescope/telescope.nvim' },
    },
    event = "User BaseFile",
    opts = function()
        local function is_whitespace(line)
            return vim.fn.match(line, [[^\s*$]]) ~= -1
        end

        local function all(tbl, check)
            for _, entry in ipairs(tbl) do
                if not check(entry) then
                    return false
                end
            end
            return true
        end

        return {
            preview = false,
            content_spec_column = true,
            enable_persistent_history = true,
            filter = function(data)
                return not all(data.event.regcontents, is_whitespace)
            end,
            keys = {
                telescope = {
                    n = {
                        replay = 'Q'
                    }
                }
            }
        }
    end,
    keys = {
        {
            "<Leader>fy",
            function()
                require('telescope').extensions.neoclip.default({
                    initial_mode = 'normal',
                    sorting_strategy = "ascending",
                    layout_strategy = "cursor",
                    layout_config = {
                        width = 0.5,
                        height = 0.4,
                    },
                })
            end,
            desc = "Find yank"
        },
    }
}