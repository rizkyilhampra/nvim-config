return {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "kevinhwang91/promise-async",
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

        vim.keymap.set('n', 'K', function()
            local winid = require('ufo').peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end)
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

        local function fold_text()
            local text = vim.treesitter.foldtext()

            local n_lines = vim.v.foldend - vim.v.foldstart
            local text_lines = " lines"

            if n_lines == 1 then
                text_lines = " line"
            end

            table.insert(text, { " - " .. n_lines .. text_lines, { "Folded" } })

            return text
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
            close_fold_kinds = { 'imports', 'comment' },
            preview = {
                win_config = {
                    border = { '', '─', '', '', '', '─', '', '' },
                    winhighlight = 'Normal:Folded',
                    winblend = 0
                },
            },
            provider_selector = function(bufnr, filetype, buftype)
                return ftMap[filetype]
            end,
            -- fold_virt_text_handler = fold_text
        })
    end
}
