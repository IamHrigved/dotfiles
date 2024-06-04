vim.g.mapleader = " "

local opts = { noremap = true }
local noremap = function(mode, key, action)
	vim.keymap.set(mode, key, action, opts)
end

-- escape from insert mode
noremap("i", "kj", "<Esc>")
-- nl to write in next line in insert mode
noremap("i", "nl", "<C-o>o")
-- press Ctrl+h or Ctrl+BS for backward deletion of a word in insert mode
-- noremap("i", "<C-h>", "<C-w>")
-- press Ctrl+l and Ctrl+h to go at the start or end of a line
noremap("i", "<C-h>", "<C-o>_")
noremap("i", "<C-l>", "<C-o>$")

-- window navigation keybindings
noremap("n", "<C-h>", "<C-w>h")
noremap("n", "<C-l>", "<C-w>l")
noremap("n", "<C-j>", "<C-w>j")
noremap("n", "<C-k>", "<C-w>k")

-- moving visual lines/blocks etc
noremap("v", "K", ":m '<-2<CR>gv=gv")
noremap("v", "J", ":m '>+1<CR>gv=gv")

noremap({ "v", "n" }, "<C-c>", '"+y')
-- to paste, just do C-S-v

-- window resizing keybindings
noremap("n", "<C-up>", "<C-w>2+")
noremap("n", "<C-down>", "<C-w>2-")
noremap("n", "<C-left>", "<C-w>5<")
noremap("n", "<C-right>", "<C-w>5>")

-- selection keybindings
noremap("n", "n", "nzz")
noremap("n", "N", "Nzz")
noremap("n", "<leader>hx", "<cmd>noh<CR>")

noremap("n", "dw", "caw")
noremap("n", "<CR>", "o<Esc>")

-- Neotree keybindings
noremap("n", "<leader>nt", "<cmd>Neotree filesystem reveal left<CR>")
noremap("n", "<leader>nx", "<cmd>Neotree close<CR>")
noremap("n", "<leader>nf", "<cmd>Neotree float reveal<CR>")
noremap("n", "<leader>ng", "<cmd>Neotree git_status left<CR>")

-- split keybindings
noremap("n", "<leader>sh", "<cmd>split<CR>")
noremap("n", "<leader>sv", "<cmd>vsplit<CR>")
noremap("n", "<leader>bd", "<cmd>bd!<CR>")
noremap("n", "<leader>sx", function()
	if #vim.api.nvim_list_wins() > 1 then
		local bufnr = vim.api.nvim_get_current_buf()
		local modifiable = vim.api.nvim_buf_get_option(bufnr, "modifiable")
		if modifiable then
			vim.cmd("w | bd!")
		else
			vim.cmd("bd!")
		end
	end
end)

-- terminal keybindings for toggleterm
function _G.set_terminal_keymaps()
	local termopts = { buffer = 0, noremap = true }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], termopts)
	vim.keymap.set("t", "kj", [[<C-\><C-n>]], termopts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], termopts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], termopts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], termopts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], termopts)
	vim.keymap.set("t", "<c-w>", [[<c-\><c-n><c-w>]], termopts)
	vim.keymap.set("t", "<M-up>", "<C-w>+", termopts)
	vim.keymap.set("t", "<M-down>", "<C-w>-", termopts)
	vim.keymap.set("t", "<M-,>", "<C-w>5<", termopts)
	vim.keymap.set("t", "<M-.>", "<C-w>5>", termopts)
end

noremap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>")
noremap("n", "<leader>tf", "<cmd>ToggleTerm direction=float name=.Terminal<CR>")

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
