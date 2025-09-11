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

-- Copilot keymaps
keymap.set("n", "<leader>cc", "<cmd>CopilotChatCommit<cr>", { desc = "CopilotChat - Generate commit message" })
keymap.set("n", "<leader>cs", "<cmd>CopilotChatCommitStaged<cr>", { desc = "CopilotChat - Generate commit message for staged changes" })
keymap.set("n", "<leader>cd", "<cmd>CopilotChatFixDiagnostic<cr>", { desc = "CopilotChat - Fix diagnostic" })
keymap.set("n", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "CopilotChat - Explain code" })
keymap.set("n", "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "CopilotChat - Review code" })
keymap.set("n", "<leader>cf", "<cmd>CopilotChatFix<cr>", { desc = "CopilotChat - Fix code" })
keymap.set("n", "<leader>co", "<cmd>CopilotChatOptimize<cr>", { desc = "CopilotChat - Optimize code" })
keymap.set("n", "<leader>ct", "<cmd>CopilotChatTests<cr>", { desc = "CopilotChat - Generate tests" })
keymap.set("n", "<leader>cp", "<cmd>CopilotChatToggle<cr>", { desc = "CopilotChat - Toggle chat panel" })
keymap.set("v", "<leader>cv", ":CopilotChatVisual<cr>", { desc = "CopilotChat - Chat with visual selection" })
keymap.set("n", "<leader>ci", ":CopilotChatInline<cr>", { desc = "CopilotChat - Quick inline chat" })

-- Copilot suggestion keymaps
keymap.set("i", "<C-y>", function()
  require("copilot.suggestion").accept()
end, { desc = "Accept Copilot suggestion" })

keymap.set("i", "<C-n>", function()
  require("copilot.suggestion").next()
end, { desc = "Next Copilot suggestion" })

keymap.set("i", "<C-p>", function()
  require("copilot.suggestion").prev()
end, { desc = "Previous Copilot suggestion" })

keymap.set("i", "<C-e>", function()
  require("copilot.suggestion").dismiss()
end, { desc = "Dismiss Copilot suggestion" })
