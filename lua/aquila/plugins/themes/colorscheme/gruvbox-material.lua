return {
    'sainnhe/gruvbox-material',
    enabled = function()
        return vim.g.aquila_theme == "gruvbox-material"
    end,
    config = function()
        vim.o.background = "dark" -- or "light" for light mode
        vim.cmd("let g:gruvbox_material_background= 'hard'")
        if vim.g.aquila_theme_transparent_mode then
            vim.cmd("let g:gruvbox_material_transparent_background=2")
            vim.cmd("let g:gruvbox_material_diagnostic_line_highlight=1")
            vim.cmd("let g:gruvbox_material_diagnostic_virtual_text='colored'")
        end
        vim.cmd("let g:gruvbox_material_enable_bold=1")
        vim.cmd("let g:gruvbox_material_enable_italic=1")

        vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
        vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
        vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
    end
}
