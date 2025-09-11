return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
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
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
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
      -- Tự động reveal file hiện tại khi mở nvim-tree
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
    
    -- Tự động reveal file hiện tại khi mở nvim-tree
    keymap.set("n", "<leader>erf", function()
      require("nvim-tree.api").tree.find_file(vim.fn.expand("%:p"))
    end, { desc = "Reveal current file in tree" })
    
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
