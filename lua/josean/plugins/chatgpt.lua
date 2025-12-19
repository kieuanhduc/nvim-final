return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("chatgpt").setup({
      api_key_cmd = "echo $OPENAI_API_KEY",
      yank_register = "+",
      edit_with_instructions = {
        diff = false,
        keymaps = {
          close = "<C-c>",
          accept = "<C-y>",
          toggle_diff = "<C-d>",
          toggle_settings = "<C-o>",
          cycle_windows = "<Tab>",
          use_output_as_input = "<C-i>",
        },
      },
      chat = {
        welcome_message = "🤖 ChatGPT Ready!",
        loading_text = "Loading...",
        question_sign = "👤",
        answer_sign = "🤖",
        max_line_length = 120,
        sessions_window = {
          border = {
            style = "rounded",
            text = { top = " Sessions " },
          },
        },
        keymaps = {
          close = { "<C-c>" },
          yank_last = "<C-y>",
          yank_last_code = "<C-k>",
          scroll_up = "<C-u>",
          scroll_down = "<C-d>",
          new_session = "<C-n>",
          cycle_windows = "<Tab>",
          select_session = "<Space>",
          rename_session = "r",
          delete_session = "d",
        },
      },
      popup_layout = {
        default = "center",
        center = {
          width = "80%",
          height = "80%",
        },
      },
      popup_window = {
        border = {
          highlight = "FloatBorder",
          style = "rounded",
          text = { top = " ChatGPT " },
        },
        win_options = {
          wrap = true,
          linebreak = true,
        },
        buf_options = {
          filetype = "markdown",
        },
      },
      openai_params = {
        model = "gpt-5-mini", -- Dùng model có sẵn trong API của bạn
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4096,
        temperature = 0.7,
        top_p = 1,
        n = 1,
      },
      openai_edit_params = {
        model = "gpt-5-mini", -- Dùng model có sẵn
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
    })
  end,
  keys = {
    -- Main chat
    { "<leader>ai", "<cmd>ChatGPT<cr>", desc = "ChatGPT: Open chat", mode = "n" },
    { "<leader>ae", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "ChatGPT: Edit with instructions", mode = { "n", "v" } },
    
    -- Quick actions
    { "<leader>ax", "<cmd>ChatGPTRun explain_code<cr>", desc = "ChatGPT: Explain code", mode = { "n", "v" } },
    { "<leader>af", "<cmd>ChatGPTRun fix_bugs<cr>", desc = "ChatGPT: Fix bugs", mode = { "n", "v" } },
    { "<leader>ao", "<cmd>ChatGPTRun optimize_code<cr>", desc = "ChatGPT: Optimize code", mode = { "n", "v" } },
    { "<leader>ag", "<cmd>ChatGPTRun grammar_correction<cr>", desc = "ChatGPT: Grammar", mode = { "n", "v" } },
    { "<leader>at", "<cmd>ChatGPTRun translate<cr>", desc = "ChatGPT: Translate", mode = { "n", "v" } },
    { "<leader>ad", "<cmd>ChatGPTRun docstring<cr>", desc = "ChatGPT: Docstring", mode = { "n", "v" } },
    { "<leader>aa", "<cmd>ChatGPTRun add_tests<cr>", desc = "ChatGPT: Add tests", mode = { "n", "v" } },
    { "<leader>as", "<cmd>ChatGPTRun summarize<cr>", desc = "ChatGPT: Summarize", mode = { "n", "v" } },
    { "<leader>al", "<cmd>ChatGPTRun code_readability_analysis<cr>", desc = "ChatGPT: Readability", mode = { "n", "v" } },
  },
}

