require("treesj").setup({
	max_join_length = 400,
})

vim.keymap.set("n", "J", require("treesj").toggle)

vim.keymap.set("n", "<leader>J", function()
	require("treesj").toggle({ split = { recursive = true } })
end)
