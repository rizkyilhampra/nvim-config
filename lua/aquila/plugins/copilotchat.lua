local prompts = {
    -- Code related prompts
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
    -- Text related prompts
    Summarize = "Please summarize the following text.",
    Spelling = "Please correct any grammar and spelling errors in the following text.",
    Wording = "Please improve the grammar and wording of the following text.",
    Concise = "Please rewrite the following text to make it more concise.",
}

return {
    "jellydn/CopilotChat.nvim",
    opts = {
        mode = "split",
        prompts = prompts,
    },
    build = function()
        vim.defer_fn(function()
            vim.cmd("UpdateRemotePlugins")
            vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
        end, 3000)
    end,
    event = "BufRead",
    keys = {
        { "<leader>cce", "<cmd>CopilotChatExplain<cr>",   desc = "CopilotChat - Explain code" },
        { "<leader>cct", "<cmd>CopilotChatTests<cr>",     desc = "CopilotChat - Generate tests" },
        { "<leader>ccr", "<cmd>CopilotChatReview<cr>",    desc = "CopilotChat - Review code" },
        { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>",  desc = "CopilotChat - Refactor code" },
        { "<leader>ccs", "<cmd>CopilotChatSummarize<cr>", desc = "CopilotChat - Summarize text" },
        { "<leader>ccS", "<cmd>CopilotChatSpelling<cr>",  desc = "CopilotChat - Correct spelling" },
        { "<leader>ccw", "<cmd>CopilotChatWording<cr>",   desc = "CopilotChat - Improve wording" },
        { "<leader>ccC", "<cmd>CopilotChatConcise<cr>",   desc = "CopilotChat - Make text concise" },
    },
}
