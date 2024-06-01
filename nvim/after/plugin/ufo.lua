vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.relativenumber = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zp", require("ufo").peekFoldedLinesUnderCursor)

local builtin = require("statuscol.builtin")
require("statuscol").setup({
	relculright = false,
	ft_ignore = { "neo-tree" },
	segments = {
		{ text = { builtin.foldfunc, "  " }, click = "v:lua.ScFa" },
		{
			text = { "%s" },
			click = "v:lua.ScSa",
		},
		{
			text = { builtin.lnumfunc, " " },
			condition = { true, builtin.not_empty },
			click = "v:lua.ScLa",
		},
	},
})

require("foldsigns").setup({
	include = nil,
	exclude = { "GitSigns.*" },
})

local foldVirtualText = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local foldedLines = endLnum - lnum
	local totalLines = vim.api.nvim_buf_line_count(0)
	local suffix = (" ........... 󰁂 %d:%d%%"):format(foldedLines, (foldedLines + 1) / totalLines * 100)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0

	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end

	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

vim.cmd("hi! MoreMsg guifg=#3f84bd")
vim.cmd("hi! Folded guibg=#1d2a41")

require("ufo").setup({
	open_fold_hl_timeout = 200,
	fold_virt_text_handler = foldVirtualText,
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
	preview = {
		win_config = {
			border = "rounded",
			winhighlight = "Normal:Folded",
			winblend = 0,
		},
		mappings = {
			scrollU = "<C-u>",
			scrollD = "<C-d>",
			jumpTop = "[",
			jumpBot = "]",
		},
	},
})
