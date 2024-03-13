return {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
        enabled = true,
        execution_message = {
            message = "Autosaving...",
            dim = 0
        },
        debounce_delay = 10000,
        condition = function(buf)
            local fn = vim.fn

            -- don't save for special-buffers
            if fn.getbufvar(buf, "&buftype") ~= '' then
                return false
            end
            return true
        end
    },
    config = function(_, opts)
        require("auto-save").setup(opts)

        local group = vim.api.nvim_create_augroup('autosave', {})
        vim.api.nvim_create_autocmd('User', {
            pattern = 'AutoSaveWritePre',
            group = group,
            callback = function(event)
                if event.data.saved_buffer ~= nil then
                    vim.cmd('highlight! link MsgArea Normal')
                end
            end,
        })
    end
}
