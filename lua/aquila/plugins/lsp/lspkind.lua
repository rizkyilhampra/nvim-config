return {
    "onsails/lspkind.nvim",
    opts = {
        mode = "symbol_text",
        symbol_map = {
            Text = ' ',
            Method = ' ',
            Function = ' ',
            Constructor = ' ',
            Field = ' ',
            Variable = ' ',
            Class = ' ',
            Interface = ' ',
            Module = ' ',
            Property = ' ',
            Unit = ' ',
            Value = ' ',
            Enum = ' ',
            Keyword = ' ',
            Snippet = ' ',
            Color = ' ',
            File = ' ',
            Reference = ' ',
            Folder = ' ',
            EnumMember = ' ',
            Constant = ' ',
            Struct = ' ',
            Event = ' ',
            Operator = ' ',
            TypeParameter = ' ',
            Copilot = ' ',
        },
        maxwidth = function()
            return math.floor(0.45 * vim.o.columns)
        end,
        ellipsis_char = '...',
        before = function(entry, vim_item)
            if entry.source.name == 'calc' then
                vim_item.kind = '  Calc'
            end

            return vim_item
        end
    },
    config = function(_, opts)
        require("lspkind").init(opts)
    end,
}