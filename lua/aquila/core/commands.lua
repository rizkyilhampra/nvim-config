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

-- Better highlight on telescope, related with autocommands.lua
function M.filenameFirst(_, path)
    local tail = vim.fs.basename(path)
    local parent = vim.fs.dirname(path)
    if parent == "." then return tail end
    return string.format("%s\t\t%s", tail, parent)
end

--- @param lines string[]
--- @return number
function M.get_indent(lines)
    local indent = 1 -- lua is one-indexed
    local indent_chars = { [" "] = true, ["\t"] = true }
    for char_idx = 1, #lines[1] do
        for _, line in ipairs(lines) do
            if #line > 0 then -- only check on non-empty lines
                local char = lines[1]:sub(char_idx, char_idx)
                if indent_chars[char] == nil then return indent end
            end
        end
        indent = indent + 1
    end

    return indent
end

return M