return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("CopilotChat").setup({
      debug = false,
      -- model = "gpt-4", -- Commented out to use default model
      temperature = 0.1,
      max_output_tokens = 1024,
      system_prompt = "You are a general AI assistant.",
      show_help = false,
      prompts = {
        Explain = {
          prompt = "/COPILOT_EXPLAIN",
          description = "Explain how the selected code works",
        },
        Review = {
          prompt = "/COPILOT_REVIEW",
          description = "Review the selected code and provide concise feedback",
        },
        Fix = {
          prompt = "/COPILOT_GENERATE",
          description = "Fix the selected code",
        },
        Optimize = {
          prompt = "/COPILOT_OPTIMIZE",
          description = "Optimize the selected code",
        },
        Tests = {
          prompt = "/COPILOT_GENERATE",
          description = "Generate tests for the selected code",
        },
        FixDiagnostic = {
          prompt = "/COPILOT_GENERATE",
          description = "Fix the diagnostic error",
          mapping = "<leader>cd",
          selection = "diagnostic",
        },
        Commit = {
          prompt = "/COPILOT_GENERATE",
          description = "Generate a commit message",
          mapping = "<leader>cc",
          selection = "gitdiff",
        },
        CommitStaged = {
          prompt = "/COPILOT_GENERATE",
          description = "Generate a commit message for staged changes",
          mapping = "<leader>cs",
          selection = "gitdiff",
        },
      },
    })

    -- Custom keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>cc", "<cmd>CopilotChatCommit<cr>", { desc = "CopilotChat - Generate commit message" })
    keymap.set("n", "<leader>cs", "<cmd>CopilotChatCommitStaged<cr>", { desc = "CopilotChat - Generate commit message for staged changes" })
    keymap.set("n", "<leader>cd", "<cmd>CopilotChatFixDiagnostic<cr>", { desc = "CopilotChat - Fix diagnostic" })
    keymap.set("n", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "CopilotChat - Explain code" })
    keymap.set("n", "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "CopilotChat - Review code" })
    keymap.set("n", "<leader>cf", "<cmd>CopilotChatFix<cr>", { desc = "CopilotChat - Fix code" })
    keymap.set("n", "<leader>co", "<cmd>CopilotChatOptimize<cr>", { desc = "CopilotChat - Optimize code" })
    keymap.set("n", "<leader>ct", "<cmd>CopilotChatTests<cr>", { desc = "CopilotChat - Generate tests" })
    keymap.set("n", "<leader>cp", "<cmd>CopilotChatToggle<cr>", { desc = "CopilotChat - Toggle chat panel" })
    keymap.set("v", "<leader>cv", ":CopilotChatVisual<cr>", { desc = "CopilotChat - Chat with visual selection" })
    keymap.set("n", "<leader>ci", ":CopilotChatInline<cr>", { desc = "CopilotChat - Quick inline chat" })
  end,
}
