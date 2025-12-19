-- Avante.nvim - AI-powered code assistant với UI đẹp (giống Cursor AI)
return {
  "yetone/avante.nvim",
  enabled = false, -- Disable vì hay lỗi, dùng ChatGPT thay thế
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    provider = "openai", -- Dùng OpenAI (không cần Copilot)
    -- Cấu hình mới theo format providers.*
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-5", -- Đổi sang gpt-3.5-turbo (cheaper & more accessible)
        timeout = 30000,
        ["local"] = false,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      -- Cấu hình cho Claude (nếu có Anthropic API key)
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 8000,
        },
      },
      -- Copilot provider (disabled - no subscription)
      -- copilot = {
      --   endpoint = "https://api.githubcopilot.com",
      --   model = "gpt-4o-2024-05-13",
      --   timeout = 30000,
      --   extra_request_body = {
      --     temperature = 0,
      --     max_tokens = 4096,
      --   },
      -- },
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    mappings = {
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },
    hints = { enabled = true },
    windows = {
      position = "right", -- Avante sidebar ở bên phải
      wrap = true,
      width = 40, -- 40% width cho Avante (60% cho code)
      sidebar_header = {
        align = "center",
        rounded = true,
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Auto vào insert mode
      },
      ask = {
        floating = false, -- Dùng split thay vì floating
        start_insert = true,
        border = "rounded",
        focus_on_apply = "ours", -- Focus về code sau khi apply
      },
    },
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    diff = {
      autojump = true,
      list_opener = "copen",
    },
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  keys = {
    { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante Ask", mode = { "n", "v" } },
    { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante Refresh" },
    { "<leader>ae", "<cmd>AvanteEdit<cr>", desc = "Avante Edit", mode = "v" },
    { "<leader>at", "<cmd>AvanteToggle<cr>", desc = "Avante Toggle" },
  },
}

