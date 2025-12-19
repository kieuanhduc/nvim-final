return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Cấu hình hiển thị blame tốt hơn
    current_line_blame = true, -- Hiển thị blame trên dòng hiện tại
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- Hiển thị ở cuối dòng
      delay = 1000, -- Delay 1 giây trước khi hiển thị
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = function(name, blame_info, opts)
      if blame_info.author == name then
        blame_info.author = "You"
      end
      local text = string.format(" %s • %s • %s", blame_info.author, blame_info.summary, blame_info.date)
      return { { text, "GitSignsCurrentLineBlame" } }
    end,

    -- Cấu hình signs để hiển thị thông tin git
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },

    -- Cấu hình preview hunk
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },

    -- Cấu hình blame để hiển thị thông tin chi tiết hơn
    blame_formatter = function(name, blame_info, opts)
      if blame_info.author == name then
        blame_info.author = "You"
      end
      local text = string.format(" %s • %s • %s", blame_info.author, blame_info.summary, blame_info.date)
      return { { text, "GitSignsCurrentLineBlame" } }
    end,

    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Navigation
      map("n", "]h", gs.next_hunk, "Next Hunk")
      map("n", "[h", gs.prev_hunk, "Prev Hunk")

      -- Actions
      map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
      map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage hunk")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset hunk")

      map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
      map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

      map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

      map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")

      -- Blame functionality
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "Blame line")
      
      map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

      map("n", "<leader>hd", gs.diffthis, "Diff this")
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, "Diff this ~")

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
    end,
  },
}
