return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]], -- Ctrl+\ để toggle terminal nhanh
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    -- Keymaps
    local keymap = vim.keymap

    -- Leader tt để toggle floating terminal
    keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
    
    -- Các keymaps bổ sung hữu ích
    keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
    keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Toggle vertical terminal" })

    -- Escape để thoát terminal mode
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- Tự động apply terminal keymaps khi mở terminal
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    -- Tạo các terminal instances có thể toggle riêng lẻ
    local Terminal = require("toggleterm.terminal").Terminal

    -- Lazygit terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "curved",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    keymap.set("n", "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Toggle lazygit" })

    -- Node REPL
    local node = Terminal:new({ 
      cmd = "node", 
      hidden = true,
      direction = "float",
    })

    function _NODE_TOGGLE()
      node:toggle()
    end

    keymap.set("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Toggle node REPL" })

    -- Python REPL
    local python = Terminal:new({ 
      cmd = "python3", 
      hidden = true,
      direction = "float",
    })

    function _PYTHON_TOGGLE()
      python:toggle()
    end

    keymap.set("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Toggle python REPL" })

    -- htop terminal
    local htop = Terminal:new({ 
      cmd = "htop", 
      hidden = true,
      direction = "float",
    })

    function _HTOP_TOGGLE()
      htop:toggle()
    end

    keymap.set("n", "<leader>tH", "<cmd>lua _HTOP_TOGGLE()<CR>", { desc = "Toggle htop" })
  end,
}

