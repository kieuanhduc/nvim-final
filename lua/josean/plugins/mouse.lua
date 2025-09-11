return {
  "nathom/filetype.nvim",
  config = function()
    require("filetype").setup({
      overrides = {
        extensions = {
          -- Set the filetype of *.md files to markdown
          md = "markdown",
        },
        literal = {
          -- Set the filetype of files named "MyBackup" to lua
          MyBackup = "lua",
        },
        complex = {
          -- Set the filetype of any full filename matching the regex to gitconfig
          [".*git/config"] = "gitconfig", -- Included in the plugin
        },
      },
    })
  end,
}
