require("codesnap").setup({
	mac_window_bar = false,
	save_path = "~/Pictures/CodeSnap",
	watermark = "iamhrigved",
	code_font_family = "JetBrainsMono Nerd Font",
	watermark_font_family = "JetBrainsMono Nerd Font",
})

vim.keymap.set("x", "<leader>cc", "<cmd>CodeSnap<CR>", {})
vim.keymap.set("x", "<leader>cs", "<cmd>CodeSnapSave<CR>", {})
