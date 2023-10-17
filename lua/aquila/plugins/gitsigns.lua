return {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPost",
    config = function()
        require('gitsigns').setup({
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Next hunk'})

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Previous hunk' })

                -- Actions
                map('n', '<leader>ghs', gs.stage_hunk, { desc = 'Stage hunk' })
                map('n', '<leader>ghr', gs.reset_hunk, { desc = 'Reset hunk' })
                map('v', '<leader>ghs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = 'Stage hunk on visual mode' })
                map('v', '<leader>ghr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = 'Reset hunk on visual mode' })
                map('n', '<leader>ghS', gs.stage_buffer, { desc = 'Stage buffer' })
                map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
                map('n', '<leader>ghR', gs.reset_buffer, { desc = 'Reset buffer' })
                map('n', '<leader>ghp', gs.preview_hunk, { desc = 'Preview hunk' })
                map('n', '<leader>ghb', function() gs.blame_line { full = true } end, { desc = 'Blame line' })
                map('n', '<leader>gtb', gs.toggle_current_line_blame, {desc = 'Toggle current line blame'})
                map('n', '<leader>ghd', gs.diffthis, { desc = 'Diff this' })
                map('n', '<leader>ghD', function() gs.diffthis('~') end, { desc = 'Diff this (ignore whitespace)' })
                map('n', '<leader>gtd', gs.toggle_deleted, { desc = 'Toggle deleted' })

                -- Text object
                map({ 'o', 'x' }, 'gih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
            end
        })
    end
}
