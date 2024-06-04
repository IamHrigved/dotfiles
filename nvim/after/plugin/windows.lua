require("windows").setup({
	autowidth = {
		enable = true,
		winwidth = 0,
		filetype = {
			help = 2,
		},
	},
	ignore = {
		buftype = { "quickfix", "terminal" },
		filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "toggleterm" },
	},
	animation = {
		enable = true, -- toggleterm not working with animation enabled
		duration = 150,
		fps = 60,
		easing = "in_out_sine",
	},
})

vim.keymap.set("n", "<leader>wm", "<cmd>WindowsMaximize<CR>", { noremap = true })
vim.keymap.set("n", "<leader>we", "<cmd>WindowsEqualize<CR>", { noremap = true })
