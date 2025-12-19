return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
    local event = "BufWritePre"
    local async = event == "BufWritePost"

    null_ls.setup({
      debug = false,
      sources = {
        -- Formatting
        formatting.prettier.with({
          extra_filetypes = { "toml" },
          extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),
        formatting.stylua,  -- Lua (install via: Mason)
        -- formatting.shfmt,   -- Shell (uncomment if needed, install via: sudo apt install shfmt)
        
        -- Diagnostics  
        -- diagnostics.eslint_d,    -- JS/TS (uncomment if needed, install via: npm install -g eslint_d)
        -- diagnostics.shellcheck,  -- Shell (uncomment if needed, install via: sudo apt install shellcheck)
        -- Note: Disable linters nếu chưa cài để tránh errors
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "Format document" })

          -- format on save
          vim.api.nvim_create_autocmd(event, {
            buffer = bufnr,
            group = group,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, async = async })
            end,
            desc = "[lsp] format on save",
          })
        end

        if client.supports_method("textDocument/rangeFormatting") then
          vim.keymap.set("x", "<leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "Format document" })
        end
      end,
    })
  end,
} 