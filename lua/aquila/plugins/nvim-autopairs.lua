return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = "windwp/nvim-ts-autotag",
    opts = {
        check_ts = true,
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0,
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    },
    config = function(_, opts)
        local npairs = require("nvim-autopairs")
        npairs.setup(opts)

        local is_cmp_loaded, cmp = pcall(require, "cmp")
        if is_cmp_loaded then
            cmp.event:on(
                "confirm_done",
                require("nvim-autopairs.completion.cmp").on_confirm_done {
                    tex = false }
            )
        end

        local brackets = {
            { '{{', '}}' }
        }
        local Rule = require('nvim-autopairs.rule')
        local cond = require('nvim-autopairs.conds')
        npairs.add_rules {
            Rule(' ', ' ')
                :with_pair(function(pairs)
                    local pair = pairs.line:sub(pairs.col - 2, pairs.col + 1)
                    return vim.tbl_contains({
                        brackets[1][1] .. brackets[1][2],
                    }, pair)
                end)
                :with_move(cond.none())
                :with_cr(cond.none())
        }
    end
}