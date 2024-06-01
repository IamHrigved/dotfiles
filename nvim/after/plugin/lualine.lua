local signs = { error = " ", warn = " ", hint = "󰌵 ", info = " " }

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' }, --  
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = { 'neo-tree' },
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = {
			'filename',
			-- {
			-- 	'diagnostics',
			-- 	diagnostics_colors = {
			-- 		error = "DiagnosticSignError",
			-- 		warn = "DiagnosticSignWarn",
			-- 		hint = "DiagnosticSignHint",
			-- 		info = "DiagnosticSignInfo",
			-- 	},
			-- 	symbols = signs,
			-- 	colored = true
			-- }
		},
		lualine_c = {
			'filetype',
			'branch', 'diff',
		},
		lualine_x = {
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			},
			{
				require("noice").api.status.command.get,
				cond = require("noice").api.status.command.has,
				color = { fg = "#ff9e64" },
			},
			'encoding'
		},
		lualine_y = { 'fileformat', 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = { 'filename' },
		lualine_c = { 'filetype' },
		lualine_x = {},
		lualine_y = { 'progress', 'location' },
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
