return {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    keys = {
        {
            "<Leader>fx",
            function() require("rip-substitute").sub() end,
            mode = { "n", "x" },
            desc = "Search and replace in the current buffer",
        },
    }
}