require("onedark").setup({
	style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = true, -- Show/hide background
	term_colors = true, -- Change terminal color as per the selected theme style
	ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

	-- toggle theme style ---
	toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
	toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

	-- Change code style ---
	-- Options are italic, bold, underline, none
	-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
	code_style = {
		comments = "none",
		keywords = "italic",
		functions = "bold",
		strings = "italic",
		variables = "bold",
	},

	-- Lualine options --
	lualine = {
		transparent = true, -- lualine center bar transparency
	},

	-- Custom Highlights --
	-- colors = {
	-- 	-- white = "#abb2bf",
	-- 	-- darker_black = "#1b1f27",
	-- 	black = "#1e222a", --  nvim bg
	-- 	-- black2 = "#252931",
	-- 	-- one_bg = "#282c34", -- real bg of onedark
	-- 	-- one_bg2 = "#353b45",
	-- 	-- one_bg3 = "#373b43",
	-- 	grey = "#42464e", -- OK
	-- 	-- grey_fg = "#565c64",
	-- 	-- grey_fg2 = "#6f737b",
	-- 	light_grey = "#6f737b", -- OK
	-- 	red = "#e06c75", -- OK
	-- 	-- baby_pink = "#DE8C92",
	-- 	-- pink = "#ff75a0",
	-- 	line = "#31353d", -- for lines like vertsplit
	-- 	green = "#98c379", -- OK
	-- 	-- vibrant_green = "#7eca9c",
	-- 	-- nord_blue = "#81A1C1",
	-- 	blue = "#61afef", -- OK
	-- 	yellow = "#e7c787", -- OK
	-- 	-- sun = "#EBCB8B",
	-- 	purple = "#de98fd", -- OK
	-- 	dark_purple = "#c882e7", -- OK
	-- 	-- teal = "#519ABA",
	-- 	orange = "#fca2aa", -- OK
	-- 	cyan = "#a3b8ef", -- OK
	-- 	-- statusline_bg = "#22262e",
	-- 	-- lightbg = "#2d3139",
	-- 	-- pmenu_bg = "#61afef",
	-- 	-- folder_bg = "#61afef",
	-- }, -- Override default colors
	highlights = {}, -- Override highlight groups

	-- Plugins Config --
	diagnostics = {
		darker = true, -- darker colors for diagnostic
		undercurl = true, -- use undercurl instead of underline for diagnostics
		background = true, -- use background color for virtual text
	},
})
-- setup must be called before loading

vim.cmd("colorscheme onedark")
