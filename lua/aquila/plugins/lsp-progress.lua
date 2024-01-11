return {
    'linrongbin16/lsp-progress.nvim',
    event = "UIEnter",
    config = function()
        require("lsp-progress").setup({
            max_size = 80,
            format = function(messages)
                local active_clients =
                    vim.lsp.get_active_clients()
                if #messages > 0 then
                    return table.concat(messages, " ")
                end
                local client_names = {}
                for _, client in ipairs(active_clients) do
                    if client and client.name ~= "" then
                        table.insert(
                            client_names,
                            1,
                            client.name
                        )
                        break
                    end
                end
                return table.concat(client_names, "  ")
            end,
        })

        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "lualine_augroup",
            pattern = "LspProgressStatusUpdated",
            callback = require("lualine").refresh,
        })
    end
}
