-- Features:
-- Search Web Directly
-- Set your preffered Search Engine
-- Support for Custom Search Engine URLs
-- Wikipedia Search Command
-- Visual Mode Search: select text or errors to search directly
return {
    "aliqyan-21/wit.nvim",
    cmd = { "WitSearch", "WitSearchVisual" },
    opts = {
        engine = "duckduckgo"
    }
}