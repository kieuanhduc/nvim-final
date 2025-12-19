return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  lazy = false, -- Load ngay, không lazy load
  -- cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
  keys = {
    { "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    { "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" },
    { "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" },
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 50,
        relativenumber = true,
      },
      -- Custom keymaps với multi-select
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        
        -- Default keymaps
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
        vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
        
        -- File operations
        vim.keymap.set("n", "a", api.fs.create, opts("Create"))
        vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
        vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
        vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
        vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
        vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
        vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
        vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
        vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
        
        -- Custom multi-select với visual indicator
        local selected_nodes = {}
        local namespace = vim.api.nvim_create_namespace("nvim_tree_marks")
        
        -- Setup custom highlight cho marked files
        vim.api.nvim_set_hl(0, "NvimTreeMarked", { fg = "#98c379", bg = "#2c323c", bold = true })
        
        -- Helper function để update visual marks
        local function update_visual_marks()
          vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
          local line_map = {}
          local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          
          -- Build map of file names to line numbers
          for i, line in ipairs(lines) do
            for path, node in pairs(selected_nodes) do
              local filename = vim.fn.fnamemodify(path, ":t")
              if line:find(filename, 1, true) then
                line_map[path] = i - 1
              end
            end
          end
          
          -- Add visual markers
          for path, line_nr in pairs(line_map) do
            local node = selected_nodes[path]
            if node then
              -- Add prominent icon at start
              vim.api.nvim_buf_set_extmark(bufnr, namespace, line_nr, 0, {
                virt_text = { { "✓ ", "DiagnosticOk" } },
                virt_text_pos = "overlay",
                hl_mode = "combine",
              })
              -- Add indicator at end
              vim.api.nvim_buf_set_extmark(bufnr, namespace, line_nr, 0, {
                virt_text = { { " [MARKED]", "NvimTreeMarked" } },
                virt_text_pos = "eol",
              })
              -- Highlight whole line
              vim.api.nvim_buf_set_extmark(bufnr, namespace, line_nr, 0, {
                end_col = 0,
                end_row = line_nr + 1,
                hl_group = "Visual",
                hl_eol = true,
              })
            end
          end
        end
        
        -- Mark file (custom implementation với visual indicator)
        vim.keymap.set("n", "m", function()
          local node = api.tree.get_node_under_cursor()
          if node then
            local path = node.absolute_path
            if selected_nodes[path] then
              selected_nodes[path] = nil
              vim.notify("Unmarked: " .. node.name, vim.log.levels.INFO)
            else
              selected_nodes[path] = node
              vim.notify("✓ Marked: " .. node.name .. " (" .. vim.tbl_count(selected_nodes) .. " total)", vim.log.levels.INFO)
            end
            update_visual_marks()
          end
        end, opts("Mark/Unmark file"))
        
        -- Show marked
        vim.keymap.set("n", "sm", function()
          local count = vim.tbl_count(selected_nodes)
          if count == 0 then
            vim.notify("No files marked", vim.log.levels.WARN)
          else
            local names = {}
            for path, node in pairs(selected_nodes) do
              table.insert(names, node.name)
            end
            vim.notify(string.format("Marked %d files:\n%s", count, table.concat(names, "\n")), vim.log.levels.INFO)
          end
        end, opts("Show marked files"))
        
        -- Delete all marked
        vim.keymap.set("n", "M", function()
          local count = vim.tbl_count(selected_nodes)
          if count == 0 then
            vim.notify("No files marked. Mark files with 'm' first!", vim.log.levels.WARN)
            return
          end
          
          local names = {}
          for _, node in pairs(selected_nodes) do
            table.insert(names, node.name)
          end
          
          local choice = vim.fn.confirm(
            string.format("Delete %d marked files?\n\n%s", count, table.concat(names, "\n")),
            "&Yes\n&No",
            2
          )
          
          if choice == 1 then
            for path, node in pairs(selected_nodes) do
              vim.fn.delete(path)
            end
            selected_nodes = {}
            vim.notify(string.format("✅ Deleted %d files!", count), vim.log.levels.INFO)
            api.tree.reload()
          end
        end, opts("Delete ALL marked files"))
        
        -- Clear marks
        vim.keymap.set("n", "cm", function()
          selected_nodes = {}
          vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
          vim.notify("Cleared all marks", vim.log.levels.INFO)
        end, opts("Clear marks"))
        
        -- Refresh visual marks khi tree refresh
        vim.keymap.set("n", "R", function()
          api.tree.reload()
          vim.defer_fn(function()
            update_visual_marks()
          end, 100)
        end, opts("Refresh"))
        
        -- Navigation
        vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
        vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
        vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
        vim.keymap.set("n", "]", api.node.navigate.sibling.next, opts("Next Sibling"))
        vim.keymap.set("n", "[", api.node.navigate.sibling.prev, opts("Previous Sibling"))
        
        -- Tree operations
        vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
        vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse All"))
        vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
        vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Hidden"))
        vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Gitignore"))
        vim.keymap.set("n", "q", api.tree.close, opts("Close"))
        
        -- Help
        vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
      end,
      -- Renderer config
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            diagnostics = true,
            bookmarks = true, -- Show bookmark icons
          },
          glyphs = {
            bookmark = "✓", -- Icon cho marked files
            folder = {
              arrow_closed = "",
              arrow_open = "",
            },
          },
        },
      },
      -- Actions config
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
      -- Auto reveal current file
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
      },
    })

    -- Autocmd để tự động reveal file khi mở nvim-tree
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        local api = require("nvim-tree.api")
        local view = require("nvim-tree.view")
        
        -- Chỉ hoạt động khi nvim-tree đang mở và không phải trong nvim-tree buffer
        if not view.is_visible() or vim.bo.filetype == "NvimTree" then
          return
        end
        
        -- Find file hiện tại trong tree
        local current_file = vim.fn.expand("%:p")
        if current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
          api.tree.find_file(current_file)
        end
      end,
    })
  end,
}
