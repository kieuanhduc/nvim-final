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
      live_update = false,
      line_sep_start = "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
      result_padding = "│  ",
      line_sep = "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffAdd",
      },
      -- UI settings
      is_insert_mode = false,
      is_block_ui_break = false,
      mapping = {
        ['toggle_line'] = {
          map = "dd",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle item"
        },
        ['enter_file'] = {
          map = "<cr>",
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = "open file"
        },
        ['send_to_qf'] = {
          map = "<leader>q",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all items to quickfix"
        },
        ['replace_cmd'] = {
          map = "<leader>c",
          cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
          desc = "input replace command"
        },
        ['show_option_menu'] = {
          map = "<leader>o",
          cmd = "<cmd>lua require('spectre').show_options()<CR>",
          desc = "show options"
        },
        ['run_current_replace'] = {
          map = "<leader>r",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line"
        },
        ['run_replace'] = {
          map = "<leader>R",
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "replace all (with confirmation)"
        },
        ['change_view_mode'] = {
          map = "<leader>v",
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "change result view mode"
        },
        ['change_replace_sed'] = {
          map = "trs",
          cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
          desc = "use sed to replace"
        },
        ['toggle_live_update'] = {
          map = "tu",
          cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
          desc = "update when vim writes to file"
        },
        ['toggle_ignore_case'] = {
          map = "ti",
          cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
          desc = "toggle ignore case"
        },
        ['toggle_ignore_hidden'] = {
          map = "th",
          cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
          desc = "toggle search hidden"
        },
        ['resume_last_search'] = {
          map = "<leader>l",
          cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
          desc = "repeat last search"
        },
      },
    })

    -- Simple keymaps
    local keymap = vim.keymap.set
    
    keymap("n", "<leader>S", function() 
      require('spectre').open()
    end, { desc = "Open Spectre" })
    
    keymap("n", "<leader>sw", function() 
      require('spectre').open_visual({select_word=true})
    end, { desc = "Search word under cursor" })
    
    keymap("v", "<leader>sw", function() 
      require('spectre').open_visual()
    end, { desc = "Search visual selection" })
    
    keymap("n", "<leader>sf", function() 
      require('spectre').open_file_search()
    end, { desc = "Search current file" })

    -- Simple replace function
    keymap("n", "<leader>sr", function()
      local search = vim.fn.input("Search for: ")
      if search == "" then return end
      
      local replace = vim.fn.input("Replace with: ")
      
      local choice = vim.fn.confirm("Replace all occurrences in current file?", "&Yes\n&No", 1)
      if choice == 1 then
        local cmd = string.format("%%s/%s/%s/g", vim.fn.escape(search, '/\\'), vim.fn.escape(replace, '/\\'))
        vim.cmd(cmd)
        vim.notify("Replace completed!", vim.log.levels.INFO)
      end
    end, { desc = "Simple replace" })

    -- Global replace function
    keymap("n", "<leader>sR", function()
      local search = vim.fn.input("Search for (all files): ")
      if search == "" then return end
      
      local replace = vim.fn.input("Replace with: ")
      
      local choice = vim.fn.confirm("Replace all occurrences in all files?", "&Yes\n&No", 1)
      if choice == 1 then
        vim.cmd(string.format("args **/*"))
        local cmd = string.format("argdo %%s/%s/%s/ge | update", vim.fn.escape(search, '/\\'), vim.fn.escape(replace, '/\\'))
        vim.cmd(cmd)
        vim.notify("Global replace completed!", vim.log.levels.INFO)
      end
    end, { desc = "Global replace" })

    -- Auto setup UI và folding trong Spectre panel
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "spectre_panel",
      callback = function()
        local buf_opts = { buffer = true, silent = true }
        
        -- KHÔNG dùng folding - Spectre có view mode riêng
        vim.opt_local.foldenable = false
        vim.opt_local.wrap = false
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        
        -- Dùng Spectre's built-in view toggle thay vì folding
        -- Press <leader>v để change view mode (collapsed/expanded)
        
        -- Safe Replace All với confirmation
        vim.keymap.set("n", "<leader>R", function()
          local state = require('spectre.state')
          local state_utils = require('spectre.state_utils')
          
          -- Get current state
          local current_state = state.get_state()
          if not current_state then
            vim.notify("No search results", vim.log.levels.WARN)
            return
          end
          
          -- Count selected items và files
          local selected_count = 0
          local files = {}
          
          for _, item in ipairs(current_state) do
            if item.selected then
              selected_count = selected_count + 1
              if not files[item.filename] then
                files[item.filename] = true
              end
            end
          end
          
          local file_count = vim.tbl_count(files)
          
          -- Warning nếu quá nhiều
          if selected_count > 100 or file_count > 20 then
            local msg = string.format(
              "⚠️  WARNING: Large operation!\n\n" ..
              "This will replace:\n" ..
              "  • %d items\n" ..
              "  • in %d files\n\n" ..
              "This may take a while and could freeze Neovim.\n" ..
              "Consider:\n" ..
              "  • Using <Tab> to deselect some items\n" ..
              "  • Using <Space>v for compact view\n" ..
              "  • Replacing in batches\n\n" ..
              "Continue anyway?",
              selected_count, file_count
            )
            
            local choice = vim.fn.confirm(msg, "&Yes\n&No\n&Cancel", 2)
            if choice ~= 1 then
              vim.notify("Replace cancelled", vim.log.levels.INFO)
              return
            end
          else
            -- Normal confirmation
            local msg = string.format(
              "Replace %d items in %d files?",
              selected_count, file_count
            )
            local choice = vim.fn.confirm(msg, "&Yes\n&No", 1)
            if choice ~= 1 then
              vim.notify("Replace cancelled", vim.log.levels.INFO)
              return
            end
          end
          
          -- Show progress notification
          vim.notify(
            string.format("Replacing %d items... Please wait...", selected_count),
            vim.log.levels.INFO
          )
          
          -- Run replace
          require('spectre.actions').run_replace()
          
          -- Success notification
          vim.defer_fn(function()
            vim.notify(
              string.format("✅ Replaced %d items in %d files!", selected_count, file_count),
              vim.log.levels.INFO
            )
          end, 1000)
        end, buf_opts)
        
        -- Navigation keymaps - Dùng TAB thay vì Space để tránh conflict
        vim.keymap.set("n", "<Tab>", "dd", buf_opts)  -- Toggle line selection với Tab
        vim.keymap.set("n", "t", "dd", buf_opts)      -- Hoặc dùng 't' (toggle)
        
        -- Navigation improvements
        vim.keymap.set("n", "j", "j", buf_opts)
        vim.keymap.set("n", "k", "k", buf_opts)
        vim.keymap.set("n", "<C-j>", "]c", buf_opts)  -- Next change
        vim.keymap.set("n", "<C-k>", "[c", buf_opts)  -- Prev change
        
        -- Enhanced colors
        vim.cmd([[
          highlight SpectreSearch guifg=#61afef guibg=#3e4451 gui=bold
          highlight SpectreReplace guifg=#98c379 guibg=#3e4451 gui=bold
          highlight SpectreFile guifg=#e5c07b gui=bold
          highlight SpectreBorder guifg=#61afef
          highlight SpectreDir guifg=#61afef gui=italic
          highlight SpectreBody guifg=#abb2bf
        ]])
        
        -- Show help hint
        vim.defer_fn(function()
          local help_msg = {
            "🔍 Spectre Search & Replace",
            "",
            "Selection:",
            "  <Tab> / t / dd → Toggle line selection",
            "  <CR>           → Open file at result",
            "",
            "Replace:",
            "  <Space>R       → Replace ALL (safe with confirmation)",
            "  <Space>r       → Replace current line only",
            "",
            "View:",
            "  <Space>v       → Toggle compact/expanded view",
            "",
            "Options:",
            "  ti             → Toggle ignore case",
            "  th             → Toggle hidden files",
            "",
            "⚠️  Warning: Replace >100 items may freeze Neovim!",
            "Tip: Use <Tab> to deselect, replace in batches.",
          }
          vim.notify(table.concat(help_msg, "\n"), vim.log.levels.INFO, { 
            timeout = 6000,
            title = "Spectre Help"
          })
        end, 500)
      end,
    })

    -- Help message
    vim.notify("Search & Replace: <leader>S=spectre, <leader>sr=simple replace, <leader>sR=global replace", vim.log.levels.INFO)
  end,
}
