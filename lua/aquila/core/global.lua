local M = {}

local append_space = function(icons)
    local result = {}
    for k, v in pairs(icons) do
        result[k] = v .. " "
    end
    return result
end

local kind_icons = {
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
    Copilot = '  '
}

M.icons = {
    -- LSP diagnostic
    diagnostic = {
        error = " ",
        warn = " ",
        hint = "󰠠 ",
        info = " "
    },
    -- LSP kinds
    kind = kind_icons,
    kind_with_space = append_space(kind_icons),
    git = {
        added = ' ',
        modified = ' ',
        removed = ' '
    }
}

return M
