-- return {
--   "folke/tokyonight.nvim",
--   priority = 1000,
--   config = function()
--     local transparent = false -- set to true if you would like to enable transparency

--     local bg = "#011628"
--     local bg_dark = "#011423"
--     local bg_highlight = "#143652"
--     local bg_search = "#0A64AC"
--     local bg_visual = "#275378"
--     local fg = "#CBE0F0"
--     local fg_dark = "#B4D0E9"
--     local fg_gutter = "#627E97"
--     local border = "#547998"

--     require("tokyonight").setup({
--       style = "night",
--       transparent = transparent,
--       styles = {
--         sidebars = transparent and "transparent" or "dark",
--         floats = transparent and "transparent" or "dark",
--       },
--       on_colors = function(colors)
--         colors.bg = bg
--         colors.bg_dark = transparent and colors.none or bg_dark
--         colors.bg_float = transparent and colors.none or bg_dark
--         colors.bg_highlight = bg_highlight
--         colors.bg_popup = bg_dark
--         colors.bg_search = bg_search
--         colors.bg_sidebar = transparent and colors.none or bg_dark
--         colors.bg_statusline = transparent and colors.none or bg_dark
--         colors.bg_visual = bg_visual
--         colors.border = border
--         colors.fg = fg
--         colors.fg_dark = fg_dark
--         colors.fg_float = fg
--         colors.fg_gutter = fg_gutter
--         colors.fg_sidebar = fg_dark
--       end,
--     })

--     vim.cmd("colorscheme tokyonight")
--   end,
-- }








return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 999,
		config = function()
			-- Set default theme
			local themes = {
				"tokyonight", -- for recording
				"accent", -- this guy is for my eyes
				"catppuccin", -- for recording
				"rose-pine", -- for fun
			}
            local current_theme_index = 1
            -- Set default theme (first theme)
            vim.cmd.colorscheme(themes[current_theme_index])

			-- Key mapping to switch themes (e.g., <leader>nt)
			vim.keymap.set("n", "<leader>nt", function()
				current_theme_index = current_theme_index + 1
				if current_theme_index > #themes then
					current_theme_index = 1
				end
				local theme = themes[current_theme_index]
				vim.cmd.colorscheme(theme)
				print("Changed nvim theme to: " .. theme)
			end, { noremap = true, silent = true })
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 800,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
	},
	{
		"alligator/accent.vim",
		name = "accent",
		priority = 1100,
	},
}
