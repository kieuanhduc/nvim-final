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
      open_cmd = "vnew",
      live_update = false, -- auto excute search again when you write any file in vim
      line_sep_start = "┌-----------------------------------------",
      result_padding = "¦  ",
      line_sep = "└-----------------------------------------",
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete",
      },
      mapping = {
        ["toggle_line"] = {
          map = "dd",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle current line",
        },
        ["enter_file"] = {
          map = "<cr>",
          cmd = "<cmd>lua require('spectre').select_file()<CR>",
          desc = "goto current file",
        },
        ["send_to_qf"] = {
          map = "<leader>q",
          cmd = "<cmd>lua require('spectre').send_to_qf()<CR>",
          desc = "send all item to quickfix",
        },
        ["replace_cmd"] = {
          map = "<leader>c",
          cmd = "<cmd>lua require('spectre').replace_cmd()<CR>",
          desc = "input replace vim command",
        },
        ["show_option_menu"] = {
          map = "<leader>o",
          cmd = "<cmd>lua require('spectre').show_options()<CR>",
          desc = "show option",
        },
        ["run_replace"] = {
          map = "<leader>R",
          cmd = "<cmd>lua require('spectre').run_replace()<CR>",
          desc = "replace all",
        },
        ["change_view_mode"] = {
          map = "<leader>v",
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "change result view mode",
        },
        ["change_replace_sed"] = {
          map = "r",
          cmd = "<cmd>lua require('spectre').change_engine_replace()<CR>",
          desc = "use sed to replace",
        },
        ["change_replace_oxi"] = {
          map = "R",
          cmd = "<cmd>lua require('spectre').change_engine_replace()<CR>",
          desc = "use oxi to replace",
        },
        ["toggle_live_update"] = {
          map = "u",
          cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
          desc = "update change when vim write file.",
        },
        ["toggle_ignore_case"] = {
          map = "i",
          cmd = "<cmd>lua require('spectre').toggle_ignore_case()<CR>",
          desc = "toggle ignore case",
        },
        ["toggle_ignore_hidden"] = {
          map = "H",
          cmd = "<cmd>lua require('spectre').toggle_ignore_hidden()<CR>",
          desc = "toggle ignore hidden",
        },
        ["resume_last_search"] = {
          map = "l",
          cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
          desc = "resume last search before close",
        },
        ["view_picker"] = {
          map = "p",
          cmd = "<cmd>lua require('spectre').view_picker()<CR>",
          desc = "view picker",
        },
      },
      find_engine = {
        -- rg is map with finder_cmd
        ["rg"] = {
          cmd = "rg",
          -- default args
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
              desc = "ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]",
            },
            ["after_context"] = {
              value = "-A",
              argument = "num",
              desc = "after context",
            },
            ["before_context"] = {
              value = "-B",
              argument = "num",
              desc = "before context",
            },
          },
        },
        ["ag"] = {
          cmd = "ag",
          args = {
            "--vimgrep",
            "--smart-case",
          },
          options = {
            ["ignore-case"] = {
              value = "-i",
              icon = "[I]",
              desc = "ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]",
            },
          },
        },
      },
      replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = nil,
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case",
            },
          },
        },
        -- call rust code by nvim-oxi to replace
        ["oxi"] = {
          cmd = "oxi",
          args = {},
          options = {
            ["ignore-case"] = {
              value = "i",
              icon = "[I]",
              desc = "ignore case",
            },
          },
        },
      },
      default = {
        find = {
          --pick one of item in find_engine
          cmd = "rg",
          options = {},
        },
        replace = {
          --pick one of item in replace_engine
          cmd = "sed",
        },
      },
      replace_vim_cmd = "cdo",
      is_open_target_win = true, --open file on opener window
      is_insert_mode = false, -- start open panel on is_insert_mode
      is_block_ui = true, -- block ui when search
    })
    
    -- Keymaps for search & replace
    local keymap = vim.keymap
    
    -- VSCode-like search & replace
    keymap.set("n", "<leader>S", "<cmd>lua require('spectre').open()<cr>", { desc = "Search & Replace (VSCode-like)" })
    keymap.set("n", "<C-S-h>", "<cmd>lua require('spectre').open()<cr>", { desc = "Search & Replace (Ctrl+Shift+H)" })
    
    -- Search & replace word under cursor
    keymap.set("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", { desc = "Search & Replace word under cursor" })
    
    -- Search & replace in visual selection
    keymap.set("v", "<leader>s", "<cmd>lua require('spectre').open_visual()<cr>", { desc = "Search & Replace visual selection" })
    
    -- Search & replace in current file
    keymap.set("n", "<leader>sf", "<cmd>lua require('spectre').open_file_search()<cr>", { desc = "Search & Replace in current file" })
  end,
}

