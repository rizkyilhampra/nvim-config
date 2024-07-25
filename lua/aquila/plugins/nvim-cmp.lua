return {
    "hrsh7th/nvim-cmp",
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    dependencies = {
        "FelipeLema/cmp-async-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-calc",
        { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "tzachar/cmp-fuzzy-buffer",
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local utils = require('aquila.core.utils')

        cmp.setup({
            view = {
                entries = {
                    follow_cursor = true
                }
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Esc>"] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    local copilot = require 'copilot.suggestion'
                    if copilot.is_visible() then
                        copilot.accept()
                    elseif cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                        else
                            cmp.confirm()
                        end
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip",  priority = 750 },
                { name = "buffer",   priority = 500 },
                { name = "calc" }
                {
                    name = 'fuzzy_buffer',
                    option = {
                        get_bufnrs = function()
                            local bufs = {}
                            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                                local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
                                if buftype ~= 'nofile' and buftype ~= 'prompt' then
                                    bufs[#bufs + 1] = buf
                                end
                            end

                            return bufs
                        end
                    },
                    priority = 500
                },
                { name = "async_path", priority = 250 },
            }),
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, item)
                    local kind = lspkind.cmp_format(utils.get_plugin_opts('lspkind.nvim'))(entry, item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })

                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = (strings[3] or "")

                    return kind
                end,
            },
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                {
                    { name = 'path' }
                },
                {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                }
            )
        })

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'fuzzy_buffer' },
            },
        })
    end,
}