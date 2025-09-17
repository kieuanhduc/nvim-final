return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local spectre = require("spectre")

    spectre.setup({
      color_devicons = true,
      open_cmd = "vnew", -- hoặc "split", "vsplit", "tabnew"
      live_update = true, -- tự động cập nhật kết quả khi lưu file
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete",
      },
      mapping = {
        ["toggle_line"] = {
          map = "dd",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "Toggle current line",
        },
        ["enter_file"] = {
          map = "<CR>",
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = "Go to file",
        },
        ["send_to_qf"] = {
          map = "<leader>q",
          cmd = "<cmd>lua require('spectre').send_to_qf()<CR>",
          desc = "Send all to quickfix",
        },
        ["replace_cmd"] = {
          map = "<leader>c",
          cmd = "<cmd>lua require('spectre').replace_cmd()<CR>",
          desc = "Input replace vim command",
        },
        ["run_replace"] = {
          map = "<leader>R",
          cmd = "<cmd>lua require('spectre').run_replace()<CR>",
          desc = "Replace all selected",
        },
        ["replace_current_line"] = {
          map = "<leader>rc",
          cmd = "<cmd>lua require('spectre').replace_cmd()<CR>",
          desc = "Replace current line",
        },
        ["toggle_ignore_case"] = {
          map = "i",
          cmd = "<cmd>lua require('spectre').toggle_ignore_case()<CR>",
          desc = "Toggle ignore case",
        },
        ["toggle_live_update"] = {
          map = "u",
          cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
          desc = "Toggle live update",
        },
      },
      find_engine = {
        ["rg"] = {
          cmd = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "Ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              icon = "[H]",
              desc = "Search hidden files",
            },
          },
        },
      },
      replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = {
            "-i",
            "",
          },
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "Ignore case",
            },
          },
        },
        -- Add simple replace engine
        ["oxi"] = {
          cmd = "oxi",
          args = {},
          options = {
            ["ignore-case"] = {
              value = "i",
              icon = "[I]",
              desc = "ignore case"
            },
          },
        },
      },
      default = {
        find = {
          cmd = "rg",
          options = { "ignore-case" },
        },
        replace = {
          cmd = "sed",
        },
      },
      is_block_ui = false, -- Don't block UI during search/replace
      is_insert_mode = false,
      use_trouble_qf = false, -- Don't use trouble for better compatibility
      replace_vim_cmd = "cdo",
      is_open_target_win = true, -- Open file on opener window
    })

    -- Keymaps: tìm kiếm & thay thế
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>", { desc = "Spectre: Open panel" })
    map("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { desc = "Spectre: Search word under cursor" })
    map("v", "<leader>sw", "<cmd>lua require('spectre').open_visual()<CR>", { desc = "Spectre: Search visual selection" })
    map("n", "<leader>sf", "<cmd>lua require('spectre').open_file_search()<CR>", { desc = "Spectre: Search current file" })

    -- Additional keymaps for Spectre panel
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "spectre_panel",
      callback = function()
        local buf_opts = { buffer = true, silent = true }
        -- Space to toggle line selection
        vim.keymap.set("n", "<Space>", "<cmd>lua require('spectre').toggle_line()<CR>", buf_opts)
        -- o to open file at line
        vim.keymap.set("n", "o", "<cmd>lua require('spectre.actions').select_entry()<CR>", buf_opts)
        -- gf to go to file
        vim.keymap.set("n", "gf", "<cmd>lua require('spectre.actions').select_entry()<CR>", buf_opts)
        -- Custom replace with notification
        vim.keymap.set("n", "R", function()
          vim.notify("Starting replace operation...", vim.log.levels.INFO)
          local ok, err = pcall(function()
            require('spectre').run_replace()
          end)
          if not ok then
            vim.notify("Replace failed: " .. tostring(err), vim.log.levels.ERROR)
          else
            vim.notify("Replace completed!", vim.log.levels.INFO)
          end
        end, buf_opts)
      end,
    })
    
    -- Simple manual replace function
    local function simple_replace()
      local search = vim.fn.input("Search for: ")
      if search == "" then return end
      
      local replace = vim.fn.input("Replace with: ")
      
      -- Ask for confirmation
      local choice = vim.fn.confirm("Replace all occurrences?", "&Yes\n&No", 1)
      if choice == 1 then
        local cmd = string.format("%%s/%s/%s/g", search, replace)
        vim.cmd(cmd)
        vim.notify("Replace completed!", vim.log.levels.INFO)
      end
    end

    -- Additional keymap for manual replace
    vim.keymap.set("n", "<leader>sr", simple_replace, { desc = "Spectre: Simple replace" })

    -- Show help when opening spectre
    vim.api.nvim_create_autocmd("User", {
      pattern = "SpectreOpen", 
      callback = function()
        vim.notify("Spectre opened! Use <leader>R to replace, <leader>sr for manual replace, Space to toggle lines", vim.log.levels.INFO)
      end,
    })
  end,
}


-- brew install ripgrep  # macOS
-- sudo apt install ripgrep  # Ubuntu/Debian
