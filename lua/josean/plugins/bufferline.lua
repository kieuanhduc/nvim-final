return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local bufferline = require("bufferline")
    
    bufferline.setup({
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        themable = true, -- allows highlight groups to be overridden which will be used to create the bufferline
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        -- NOTE: this plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- as an escape hatch for people who cannot bear it for whatever reason
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "icon", -- | 'underline' | 'none',
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "󰅖",
        left_trunc_marker = "󰅖",
        right_trunc_marker = "󰅖",
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it may
        --- break in some scenarios.
        name_formatter = function(buf) -- buf contains:
          -- name                | str        | the basename of the active file
          -- path                | str        | the full path of the active file
          -- bufnr (buffer only)| int        | the number of the active buffer
          -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
          -- tabpages (tabs only) | table(int) | the numbers of the tabpages in the tab
          -- to return a string, use this return value
          -- return something like "My buffer name"
        end,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return "(" .. count .. ")"
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number, buf_numbers)
          -- filter out filetypes you don't want to see
          if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
            return true
          end
          -- filter out by buffer name
          if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
            return true
          end
          -- filter out based on arbitrary rules
          -- e.g. filter out vim wiki buffer from tabline in your work repo
          if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
            return true
          end
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          },
        },
        color_icons = true, -- whether or not to add the filetype icon highlights
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_tab_name = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_after_current", -- |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
          -- add custom logic
          -- return buffer_a.modified > buffer_b.modified
        -- end
      },
    })

    -- Keymaps for bufferline
    local keymap = vim.keymap

    keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Toggle Pin" })
    keymap.set("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Delete Non-Pinned Buffers" })
    keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Delete Other Buffers" })
    keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Delete Buffers to the Right" })
    keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Delete Buffers to the Left" })
    keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })
    keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
    keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })
    keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
  end,
}