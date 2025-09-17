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

      -- -- Tạo hover để hiển thị commit info
      -- local function show_commit_hover()
      --   -- Sử dụng blame_line để hiển thị thông tin commit
      --   gs.blame_line({ full = true })
      -- end
      --
      -- -- Tự động hiển thị commit info khi hover - sử dụng timer để tránh spam
      -- local hover_timer = nil
      -- vim.api.nvim_create_autocmd("CursorHold", {
      --   buffer = bufnr,
      --   callback = function()
      --     local hover_enabled = vim.b.gitsigns_hover_enabled
      --     if hover_enabled == nil then hover_enabled = true end
      --
      --     if hover_enabled and vim.bo.filetype ~= "" then
      --       if hover_timer then
      --         hover_timer:stop()
      --       end
      --       hover_timer = vim.defer_fn(function()
      --         show_commit_hover()
      --       end, 500) -- Delay 500ms
      --     end
      --   end,
      -- })
      --
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

      -- Blame functionality - cải thiện với thông tin commit chi tiết
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "Blame line (full info)")

      map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

      -- Hiển thị thông tin commit chi tiết (hash, description, comment)
      map("n", "<leader>hc", function()
        -- Sử dụng blame_line để hiển thị thông tin commit
        gs.blame_line({ full = true })
      end, "Show commit info popup")

      -- Hiển thị commit diff - sử dụng git command trực tiếp
      map("n", "<leader>hcd", function()
        -- Sử dụng blame_line để hiển thị thông tin commit trước
        gs.blame_line({ full = true })
        -- Sau đó có thể dùng Git show với commit hash từ blame output
        vim.notify("Use the commit hash from blame popup to run: Git show <hash>", vim.log.levels.INFO)
      end, "Show commit diff")

      -- Copy commit hash - sử dụng cách đơn giản hơn
      map("n", "<leader>hcc", function()
        -- Hiển thị blame để user có thể copy hash manually
        gs.blame_line({ full = true })
        vim.notify("Copy the commit hash from the blame popup", vim.log.levels.INFO)
      end, "Copy commit hash")

      -- Thêm keymap để hiển thị blame cho toàn bộ file
      map("n", "<leader>hbb", function()
        gs.blame_line({ full = true, ignore_whitespace = false })
      end, "Blame line with whitespace")

      -- Blame cho visual selection - sử dụng keymap khác để tránh xung đột
      map("v", "<leader>hvb", function()
        local start_line = vim.fn.line("v")
        local end_line = vim.fn.line(".")
        gs.blame_line({ full = true, lnum = start_line })
      end, "Blame visual selection")

      -- Toggle blame cho toàn bộ buffer
      map("n", "<leader>hT", function()
        gs.toggle_current_line_blame()
      end, "Toggle blame display")

      -- Toggle hover commit info
      map("n", "<leader>hh", function()
        local hover_enabled = vim.b.gitsigns_hover_enabled
        if hover_enabled == nil then hover_enabled = true end

        vim.b.gitsigns_hover_enabled = not hover_enabled
        if hover_enabled then
          vim.notify("Git hover disabled", vim.log.levels.INFO)
        else
          vim.notify("Git hover enabled", vim.log.levels.INFO)
        end
      end, "Toggle hover commit info")

      -- Debug keymap để test blame info
      map("n", "<leader>hdd", function()
        -- Hiển thị blame để debug
        gs.blame_line({ full = true })
        vim.notify("Blame popup displayed - check the commit information", vim.log.levels.INFO)
      end, "Debug blame info")

      map("n", "<leader>hd", gs.diffthis, "Diff this")
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, "Diff this ~")

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
    end,
  },
}
