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

M.event = {
    LazyFile = {
        "BufReadPost",
        "BufWritePost",
        "BufNewFile",
    }
}

M.capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    return capabilities
end

M.default_diagnostic = {
    update_in_insert = false,
    virtual_text = false,
    -- virtual_text = {
    --     spacing = 4,
    --     prefix = "● ",
    --     source = true
    -- },
    float = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'if_many',
        -- source = 'always',
        prefix = ' ',
        scope = 'line',
    },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = M.icons.diagnostic.error,
            [vim.diagnostic.severity.WARN] = M.icons.diagnostic.warn,
            [vim.diagnostic.severity.HINT] = M.icons.diagnostic.hint,
            [vim.diagnostic.severity.INFO] = M.icons.diagnostic.info,
        },
    }
}
M.diagnostics = {
    -- virtual_text diagnostic off
    [0] = vim.tbl_deep_extend(
        "force",
        M.default_diagnostic,
        { virtual_text = false }
    ),

    -- all diagnostics on
    M.default_diagnostic,
}

return M