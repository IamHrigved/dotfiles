local builtin = require("telescope.builtin")
local trouble = require("trouble.sources.telescope")
local z_utils = require("telescope._extensions.zoxide.utils")

local function getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>gs", builtin.grep_string, {})
vim.keymap.set("v", "gs", function()
	return builtin.grep_string({ default_text = getVisualSelection() })
end, {})
vim.keymap.set("n", "<leader>of", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fc", builtin.commands, {})

vim.keymap.set("n", "gr", builtin.lsp_references, {})
vim.keymap.set("n", "gi", builtin.lsp_implementations, {})
vim.keymap.set("n", "<leader>dg", builtin.diagnostics, {})
vim.keymap.set("n", "dg", function()
	return builtin.diagnostics({ bufnr = 0 })
end, {})

require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<c-t>"] = trouble.open },
			n = { ["<c-t>"] = trouble.open },
		},
	},
	extensions = {
		zoxide = {
			prompt_title = " Zoxide ",
			mappings = {
				default = {
					action = function(selection)
						vim.cmd("SessionSave")
						if vim.bo.filetype == "alpha" then
							vim.cmd("BufDel!")
						else
							vim.cmd("BufDelAll")
						end
						vim.cmd.cd(selection.path)
					end,
					after_action = function(selection)
						print('Switched to "' .. selection.path .. '"')
						vim.schedule(function()
							vim.cmd("silent SessionLoad")
						end)
					end,
				},
				["<C-Space>"] = {
					action = function(selection)
						vim.cmd("SessionSave")
						vim.cmd.cd(selection.path)
					end,
					after_action = function(selection)
						print("Director changed to " .. selection.path)
						vim.schedule(function()
							vim.cmd("SessionLoad")
						end)
					end,
				},
				["<C-s>"] = { action = z_utils.create_basic_command("split") },
				["<C-v>"] = { action = z_utils.create_basic_command("vsplit") },
				["<C-e>"] = { action = z_utils.create_basic_command("edit") },
				["<C-q>"] = { action = z_utils.create_basic_command("split") },
				["<C-t>"] = {},
			},
		},
	},
})
require("telescope").load_extension("ui-select")
require("telescope").load_extension("persisted")
require("telescope").load_extension("zoxide")

vim.keymap.set("n", "<leader>cd", require("telescope").extensions.zoxide.list)
