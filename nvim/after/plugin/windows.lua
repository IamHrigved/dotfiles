require("windows").setup({
	autowidth = { --		       |windows.autowidth|
		enable = true,
		winwidth = 0, --		        |windows.winwidth|
		filetype = { --	      |windows.autowidth.filetype|
			help = 2,
		},
	},
	ignore = { --			  |windows.ignore|
		buftype = { "quickfix", "terminal" },
		filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "toggleterm" }
	},
	animation = {
		enable = false, -- toggleterm not working with animation enabled
		duration = 250,
		fps = 60,
		easing = "in_out_sine"
	},
})

vim.keymap.set("n", "<leader>wm", "<cmd>WindowsMaximize<CR>", { noremap = true })
vim.keymap.set("n", "<leader>we", "<cmd>WindowsEqualize<CR>", { noremap = true })
