return {
    "kevinhwang91/nvim-ufo",
    event = "BufRead",
    dependencies = {
        "kevinhwang91/promise-async",
        "luukvbaal/statuscol.nvim",
    },
    opts = {},
    keys = function()
        vim.keymap.set("n", "zR", function()
            require("ufo").openAllFolds()
        end, {
            desc = "Open all fold"
        })

        vim.keymap.set("n", "zM", function()
            require("ufo").closeAllFolds()
        end, { desc = "Close all fold" })
    end,
    config = function()
        local function get_comment_folds(bufnr)
            local comment_folds = {}
            local line_count = vim.api.nvim_buf_line_count(bufnr)
            local is_in_comment = false
            local comment_start = 0

            for i = 0, line_count - 1 do
                local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
                if not is_in_comment and line:match('^%s*' .. vim.o.commentstring:sub(1, 1)) then
                    is_in_comment = true
                    comment_start = i
                elseif is_in_comment and not line:match('^%s*' .. vim.o.commentstring:sub(1, 1)) then
                    is_in_comment = false
                    table.insert(comment_folds, { startLine = comment_start, endLine = i - 1 })
                end
            end

            if is_in_comment then
                table.insert(comment_folds, { startLine = comment_start, endLine = line_count - 1 })
            end

            return comment_folds
        end

        local function treesitter_and_comment_folding(bufnr)
            local comment_folds = get_comment_folds(bufnr)
            local lsp_folds = require('ufo').getFolds(bufnr, "treesitter")
            for _, fold in ipairs(comment_folds) do
                table.insert(lsp_folds, fold)
            end
            return lsp_folds
        end

        local ftMap = {
            vim = 'indent',
            git = 'indent',
            bash = 'indent',
            lua = function(bufnr)
                return treesitter_and_comment_folding(bufnr)
            end
        }

        require('ufo').setup({
            close_fold_kinds_for_ft = {
                default = {
                    'imports', 'comment'
                }
            },
            preview = {
                win_config = {
                    winblend = 0,
                },
            },
            provider_selector = function(_, filetype, _)
                return ftMap[filetype]
            end,
        })
    end
}