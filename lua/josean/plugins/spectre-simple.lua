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
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete",
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

    -- Help message
    vim.notify("Search & Replace: <leader>S=spectre, <leader>sr=simple replace, <leader>sR=global replace", vim.log.levels.INFO)
  end,
}
