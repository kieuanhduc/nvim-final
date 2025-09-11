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
        -- Formatters
        "prettier", -- JS, TS, HTML, CSS formatter
        "stylua",  -- Lua formatter
        "shfmt",   -- shell formatter
        "php-cs-fixer", -- PHP formatter
        -- Linters
        "eslint_d", -- JS/TS linter
        "shellcheck", -- shell linter
      
        "jsonlint", -- json linter
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
}
