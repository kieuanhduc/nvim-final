return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },

    config = function()
      require("codecompanion").setup({

        ------------------------------------------------------------------
        -- ADAPTER
        ------------------------------------------------------------------
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "OPENAI_API_KEY",
                url = "OPENAI_BASE_URL", -- Optional
              },
              schema = {
                model = {
                  default = "gpt-5-mini", -- Dùng model có sẵn
                },
                max_tokens = {
                  default = 4096,
                },
                temperature = {
                  default = 0.7,
                },
              },
            })
          end,
        },

        ------------------------------------------------------------------
        -- STRATEGIES
        ------------------------------------------------------------------
        strategies = {
          chat = { adapter = "openai" },
          inline = { adapter = "openai" },
        },

        ------------------------------------------------------------------
        -- DISPLAY (CHATGPT.NVIM STYLE)
        ------------------------------------------------------------------
        display = {
          chat = {
            window = {
              layout = "float",
              width = 0.90,
              height = 0.90,
              border = "rounded",
              title = " 🤖 ChatGPT ",
              title_pos = "center",

              win_options = {
                wrap = true,
                linebreak = true,
                number = false,
                relativenumber = false,
                signcolumn = "no",
                cursorline = false,
              },
            },

            -- Prefix giống ChatGPT.nvim
            intro_message = "🤖 ChatGPT Ready!",
            user_prefix = "👤 ",
            assistant_prefix = "🤖 ",
          },

          ----------------------------------------------------------------
          -- INPUT BOX (DƯỚI)
          ----------------------------------------------------------------
          input = {
            window = {
              border = "rounded",
              title = " Prompt ",
              title_pos = "center",
            },
          },
        },

        ------------------------------------------------------------------
        -- CHAT BEHAVIOR
        ------------------------------------------------------------------
        chat = {
          render_headers = false, -- ❗ giống ChatGPT.nvim (ít tiêu đề)
          show_token_count = false,
        },
      })

      --------------------------------------------------------------------
      -- KEYMAPS (Y CHANG CHATGPT.NVIM)
      --------------------------------------------------------------------
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

    end,
    keys = {
      -- Main chat
      { "<leader>ai", "<cmd>CodeCompanionChat<cr>", desc = "AI: Chat", mode = "n" },
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI: Toggle", mode = "n" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI: Actions menu", mode = { "n", "v" } },
      
      -- Inline với selected code - ĐÂY LÀ CÁCH ĐÚNG!
      { "<leader>ae", "<cmd>CodeCompanion<cr>", desc = "AI: Inline (type prompt)", mode = { "n", "v" } },
      { "<leader>ax", "<cmd>CodeCompanionActions<cr>", desc = "AI: Explain/Actions", mode = { "n", "v" } },
    },
  },
}
