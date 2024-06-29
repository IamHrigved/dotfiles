local DiagnosticSigns = vim.g.DiagnosticSigns
for type, icon in pairs(DiagnosticSigns) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.wildmenu = false
vim.opt.showmode = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

vim.opt.updatetime = 50

vim.opt.smartindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.smoothscroll = true

vim.opt.guicursor = "n-c-v-i:block,o:hor40,i:blinkwait150-blinkon150-blinkoff150"

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
