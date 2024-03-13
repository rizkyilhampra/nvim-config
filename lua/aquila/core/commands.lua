local M = {}

-- DUPLICATE VISUAL SELECTION
function M.duplicate_selection()
    local save_reg = vim.fn.getreginfo([["]])

    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" then
        vim.fn.execute [[noautocmd normal! y`>p]]
    elseif mode == "n" then
        vim.fn.execute [[noautocmd normal! yyP]]
        -- vim.fn.execute [[noautocmd normal! yyPgvy`[v`]=]]
    end

    vim.fn.setreg([["]], save_reg.regcontents, save_reg.regtype)
end

return M
