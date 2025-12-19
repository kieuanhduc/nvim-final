return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        -- JS/TS
        "ts_ls",
        "eslint",
        -- Web
        "html",
        "cssls",
        "tailwindcss",
        "emmet_ls",
        -- PHP
        "intelephense", -- PHP LSP server
        -- Lua
        "lua_ls",
        -- Others
        "svelte",
        "graphql",
        "prismals",
        "pyright",
        "bashls",
        "dockerls",
        "jsonls",
        "yamlls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        -- Formatters (sẽ tự động cài)
        "prettier",    -- JS, TS, HTML, CSS, JSON formatter
        "stylua",      -- Lua formatter
        -- "shfmt",    -- Shell formatter (optional)
        -- "php-cs-fixer", -- PHP formatter (optional)
        
        -- Linters (optional - comment nếu không cần)
        -- "eslint_d",    -- JS/TS linter
        -- "shellcheck",  -- Shell linter
        
        -- Note: jsonlint không có trong Mason registry
      },
      auto_update = false,      -- Đổi false để tránh auto update
      run_on_start = true,
    })
  end,
}
