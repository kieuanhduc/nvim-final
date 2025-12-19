vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- File explorer - chỉ giữ lại keymaps không bị overlap
keymap.set("n", "<leader>E", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })

-- File explorer shortcuts
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh file explorer" })
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Find file in explorer" })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<cr>", { desc = "Collapse explorer" })

-- Simple git commit message helper (thay thế Copilot)
keymap.set("n", "<leader>cc", function()
  -- Get git diff
  local diff = vim.fn.system("git diff --cached --stat")
  if diff == "" then
    vim.notify("No staged changes. Stage files first with: git add", vim.log.levels.WARN)
    return
  end
  
  -- Simple commit message prompt
  vim.ui.input({ prompt = "Commit message: " }, function(msg)
    if msg and msg ~= "" then
      local result = vim.fn.system(string.format('git commit -m "%s"', msg))
      if vim.v.shell_error == 0 then
        vim.notify("✅ Committed: " .. msg, vim.log.levels.INFO)
      else
        vim.notify("❌ Commit failed: " .. result, vim.log.levels.ERROR)
      end
    end
  end)
end, { desc = "Git commit" })

-- Quick git add + commit
keymap.set("n", "<leader>ca", function()
  -- Add all and commit
  vim.ui.input({ prompt = "Commit message (will add all): " }, function(msg)
    if msg and msg ~= "" then
      vim.fn.system("git add .")
      local result = vim.fn.system(string.format('git commit -m "%s"', msg))
      if vim.v.shell_error == 0 then
        vim.notify("✅ Added & Committed: " .. msg, vim.log.levels.INFO)
      else
        vim.notify("❌ Commit failed: " .. result, vim.log.levels.ERROR)
      end
    end
  end)
end, { desc = "Git add all & commit" })
