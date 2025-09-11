return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
    local event = "BufWritePre" -- or "BufWritePost"
    local async = event == "BufWritePost"

    null_ls.setup({
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

    -- register any number of sources simultaneously
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    null_ls.setup({
      debug = false,
      sources = {
        -- Formatting
        formatting.prettier.with({
          extra_filetypes = { "toml" },
          extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),
        formatting.stylua, -- Lua formatter
        formatting.shfmt, -- Shell formatter
    
        -- Diagnostics
        diagnostics.eslint_d, -- JS/TS linter
        diagnostics.shellcheck, -- Shell linter
     
        diagnostics.jsonlint, -- JSON linter
      },
    })
  end,
} 