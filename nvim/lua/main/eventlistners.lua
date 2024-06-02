-- Formatting on file save
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Formatting on file save",
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Highlight the text when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "AlphaReady",
	desc = "Disable statusline in startup screen",
	callback = function()
		vim.go.laststatus = 0
	end,
})

vim.api.nvim_create_autocmd("BufUnload", {
	buffer = 0,
	-- pattern = 'AlphaClosed',
	desc = "Enable statusline after startup screen",
	callback = function()
		vim.go.laststatus = 2
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Changing the name of ToggleTerm when we enter it",
	callback = function()
		vim.schedule(function()
			if vim.o.filetype == "toggleterm" then
				vim.cmd("file Terminal | startinsert")
			end
		end)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Disabling Windows plugin when entering a trouble window",
	callback = function()
		vim.schedule(function()
			if vim.o.filetype == "trouble" then
				vim.cmd("WindowsDisableAutowidth")
			end
		end)
	end,
})

vim.api.nvim_create_autocmd("BufLeave", {
	desc = "Enabling Windows plugin when leaving a trouble window",
	callback = function()
		vim.schedule(function()
			if vim.o.filetype == "trouble" then
				vim.cmd("WindowsEnableAutowidth")
			end
		end)
	end,
})

-- vim.api.nvim_create_autocmd('FileType', {
-- 	desc = "Opening help window in vertical split instead of horizontal",
-- 	pattern = ".*help",
-- 	callback = function()
-- 		vim.cmd("wimcmd L")
-- 	end
-- })

local get_icon_hl = function()
	local filename = vim.fn.expand("%:t")
	local _, color = require("nvim-web-devicons").get_icon_color(filename)
	if color == nil then
		return ""
	end
	local hlcmd = "hi! BufferLineIndicatorSelected guifg=" .. color
	return hlcmd
end

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Changing the BufferLineIndicatorSelected highlight according to the color of icon",
	callback = function()
		vim.cmd(get_icon_hl())
	end,
})
