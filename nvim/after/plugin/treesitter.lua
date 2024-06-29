require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

	sync_install = false,
	auto_install = true,
	ignore_install = {},
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-s>",
			node_incremental = "<C-s>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = { -- for scope keymaps, look indents.lua
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["at"] = "@comment.outer",
				["it"] = "@comment.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				["[l"] = "@loop.outer",
				["[i"] = "@conditional.outer",
			},
			goto_previous = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				["]l"] = "@loop.outer",
				["]i"] = "@conditional.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = "rounded",
			floating_preview_opts = {},
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
	},
})
