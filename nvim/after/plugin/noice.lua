require("noice").setup({
	cmdline = {
		enabled = true, -- enables the Noice cmdline UI
		view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
		format = {
			-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
			-- view: (default is cmdline view)
			-- opts: any options passed to the view
			-- icon_hl_group: optional hl_group for the icon
			-- title: set to anything or empty string to hide
			cmdline = { pattern = "^:", icon = "", lang = "vim" },
			search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
			search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
			filter = { title = " Command ", pattern = "^:%s*!", icon = "$ ", lang = "bash" },
			lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
			help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
			input = {}, -- Used by input()
			-- lua = false, -- to disable a format, set to `false`
		},
	},
	messages = {
		-- NOTE: If you enable messages, then the cmdline is enabled automatially.
		-- This is a current Neovim limitation.
		enabled = true, -- enables the Noice messages UI
		view = "notify", -- default view for messages
		view_error = "notify", -- view for errors
		view_warn = "notify", -- view for warnings
		view_history = "messages", -- view for :messages
		view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
	},
	popupmenu = {
		enabled = false, -- enables the Noice popupmenu UI
		---@type 'nui'|'cmp'
		backend = "nui", -- backend to use to show regular cmdline completions
		-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
		kind_icons = {}, -- set to `false` to disable icons
	},
	-- default options for require('noice').redirect
	-- see the section on Command Redirection
	redirect = {
		view = "popup",
		filter = { event = "msg_show" },
	},
	-- You can add any custom commands below that will be available with `:Noice command`
	commands = {
		history = {
			-- options for the message history that you get with `:Noice`
			view = "popup",
			opts = {
				enter = true,
				format = "details",
				position = "50%",
				size = {
					width = "90%",
					height = "80%",
				},
			},
			filter = {
				any = {
					{ event = "notify" },
					{ error = true },
					{ warning = true },
					{ event = "msg_show", kind = { "" } },
					{ event = "lsp", kind = "message" },
				},
			},
		},
		all = {
			view = "popup",
			opts = {
				enter = true,
				format = "details",
				position = "50%",
				size = {
					width = "90%",
					height = "80%",
				},
			},
		},
		-- :Noice last
		last = {
			view = "popup",
			opts = { enter = true, format = "details" },
			filter = {
				any = {
					{ event = "notify" },
					{ error = true },
					{ warning = true },
					{ event = "msg_show", kind = { "" } },
					{ event = "lsp", kind = "message" },
				},
			},
			filter_opts = { count = 1 },
		},
		-- :Noice errors
		errors = {
			-- options for the message history that you get with `:Noice`
			view = "popup",
			opts = { enter = true, format = "details" },
			filter = { error = true },
			filter_opts = { reverse = true },
		},
	},
	notify = {
		-- Noice can be used as `vim.notify` so you can route any notification like other messages
		-- Notification messages have their level and other properties set.
		-- event is always "notify" and kind can be any log level as a string
		-- The default routes will forward notifications to nvim-notify
		-- Benefit of using Noice for this is the routing and consistent history view
		enabled = true,
		view = "notify",
		replace = false,
	},
	lsp = {
		progress = {
			enabled = true,
			-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
			-- See the section on formatting for more details on how to customize.
			format = "lsp_progress",
			format_done = "lsp_progress_done",
			throttle = 10 / 30, -- frequency to update lsp progress message
			view = "mini",
		},
		override = {
			-- override the default lsp markdown formatter with Noice
			["vim.lsp.util.convert_input_to_markdown_lines"] = false,
			-- override the lsp markdown formatter with Noice
			["vim.lsp.util.stylize_markdown"] = false,
			-- override cmp documentation with Noice (needs the other options to work)
			["cmp.entry.get_documentation"] = false,
		},
		hover = {
			enabled = true,
			silent = false, -- set to true to not show a message if hover is not available
			view = "hover", -- when nil, use defaults from documentation
			opts = {}, -- merged with defaults from documentation
		},
		signature = {
			enabled = true,
			auto_open = {
				enabled = true,
				trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
				luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
				throttle = 50, -- Debounce lsp signature help request by 50ms
			},
			view = nil, -- when nil, use defaults from documentation
			opts = {}, -- merged with defaults from documentation
		},
		message = {
			-- Messages shown by lsp servers
			enabled = true,
			view = "notify",
			opts = {},
		},
		-- defaults for hover and signature help
		documentation = {
			view = "hover",
			opts = { -- lsp_docs settings
				lang = "markdown",
				replace = true,
				render = "plain",
				format = { "{message}" },
				position = { row = 2, col = 2 },
				size = {
					max_width = math.floor(0.8 * vim.api.nvim_win_get_width(0)),
					max_height = 15,
				},
				border = {
					style = "rounded",
				},
				win_options = {
					concealcursor = "n",
					conceallevel = 0,
					winhighlight = {
						Normal = "CmpPmenu",
						FloatBorder = "DiagnosticSignInfo",
					},
				},
			},
		},
	},
	markdown = {
		hover = {
			["|(%S-)|"] = vim.cmd.help, -- vim help links
			["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
		},
		highlights = {
			["|%S-|"] = "@text.reference",
			["@%S+"] = "@parameter",
			["^%s*(Parameters:)"] = "@text.title",
			["^%s*(Return:)"] = "@text.title",
			["^%s*(See also:)"] = "@text.title",
			["{%S-}"] = "@parameter",
		},
	},
	health = {
		checker = true, -- Disable if you don't want health checks to run
	},
	smart_move = {
		-- noice tries to move out of the way of existing floating windows.
		enabled = true, -- you can disable this behaviour here
		-- add any filetypes here, that shouldn't trigger smart move.
		excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
	},
	presets = {
		-- you can enable a preset by setting it to true, or a table that will override the preset config
		-- you can also add custom presets that you can enable/disable with enabled=true
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = true, -- enables an input dialog for inc-rename.nvim
	},
	throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
	views = {
		split = {
			win_options = {
				winhighlight = { Normal = "Normal" },
				winblend = 0,
			},
		},
		popup = {
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticSignInfo" },
				winblend = 0,
			},
		},
		mini = {
			win_options = {
				winhighlight = { Normal = "Normal" },
				winblend = 0,
			},
		},
		vsplit = {
			win_options = {
				winhighlight = { Normal = "Normal" },
				winblend = 0,
			},
		},
	},
	cmdline_popup = {}, ---@see section on views
	routes = {
		{
			filter = {
				event = "msg_show",
				find = "Some options have changed, please run `:Neotree migrations` to see the changes",
			},
			opts = {
				skip = true,
			},
		},
		{
			filter = {
				event = "msg_show",
				any = {
					min_width = 20,
					min_height = 2,
				},
			},
			view = "split",
		},
	}, --- @see section on routes
	status = {}, --- @see section on statusline components
	format = {
		lsp_progress_done = {
			{ " ", hl_group = "NoiceLspProgressSpinner" },
			{ "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
			{ "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
		},
	}, --- @see section on formatting
})

require("notify").setup({
	background_colour = "#000000",
})

vim.keymap.set("n", "<leader>no", "<cmd>Noice<CR>")
vim.keymap.set("n", "<leader>na", "<cmd>Noice all <CR>")
vim.keymap.set("n", "<leader>nq", function()
	require("notify").dismiss({ silent = true, pending = true })
end)
