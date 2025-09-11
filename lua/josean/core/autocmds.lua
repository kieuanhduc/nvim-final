local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = "1000" })
  end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "",
  command = ":%s/\\s\\+$//e",
})

-- Don't auto comment new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

-- Set indentation for specific file types
autocmd("FileType", {
  pattern = { "json", "jsonc" },
  command = "setlocal shiftwidth=4 tabstop=4",
})

autocmd("FileType", {
  pattern = { "yaml", "yml" },
  command = "setlocal shiftwidth=4 tabstop=4",
})

autocmd("FileType", {
  pattern = { "markdown", "md" },
  command = "setlocal wrap linebreak",
})

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Wrap and check for spell in text filetypes
autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory doesn't exist
autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if args.match and args.match ~= "" and args.match ~= "NvimTree_1" then
      vim.fn.mkdir(vim.fn.fnamemodify(args.match, ":p:h"), "p")
    end
  end,
})

-- Shell syntax highlighting
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.sh", "*.bash", "*.zsh", "*.fish", "*.csh", "*.tcsh", "*.ksh" },
  callback = function()
    vim.bo.filetype = "sh"
    vim.bo.shell = "bash"
    
    -- Force enable syntax highlighting
    vim.cmd("syntax on")
    vim.cmd("filetype on")
    vim.cmd("filetype plugin on")
    vim.cmd("filetype indent on")
    
    -- Set proper indentation
    vim.bo.expandtab = true
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.commentstring = "# %s"
    
    -- Enable line numbers
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})

-- Shebang detection
autocmd({ "BufRead" }, {
  pattern = "*",
  callback = function()
    local first_line = vim.fn.getline(1)
    if string.match(first_line, "^#!.*bash") or string.match(first_line, "^#!.*sh") then
      vim.bo.filetype = "sh"
      vim.cmd("syntax on")
    end
  end,
})

-- Shell script support
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.sh", "*.bash", "*.zsh", "*.fish", "*.csh", "*.tcsh" },
  callback = function()
    vim.bo.filetype = "sh"
    vim.bo.expandtab = true
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.commentstring = "# %s"
    -- Force enable syntax highlighting
    vim.cmd("syntax on")
    vim.cmd("filetype on")
    vim.cmd("filetype plugin on")
    vim.cmd("filetype indent on")
  end,
})

-- Shebang detection
autocmd({ "BufRead" }, {
  pattern = "*",
  callback = function()
    local first_line = vim.fn.getline(1)
    if string.match(first_line, "^#!.*bash") or string.match(first_line, "^#!.*sh") then
      vim.bo.filetype = "sh"
      vim.cmd("syntax on")
    end
  end,
})

-- .env file support
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.env", "*.env.*", ".env*" },
  callback = function()
    vim.bo.filetype = "dotenv"
    vim.bo.expandtab = true
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    -- Enable syntax highlighting
    vim.cmd("syntax on")
    vim.cmd("syntax match dotenvKey /^[A-Za-z_][A-Za-z0-9_]*/")
    vim.cmd("syntax match dotenvValue /=\zs.*$/")
    vim.cmd("highlight dotenvKey guifg=#61afef")
    vim.cmd("highlight dotenvValue guifg=#98c379")
  end,
}) 