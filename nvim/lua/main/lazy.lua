local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {

	-- [[ Essentials: ]] --
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		-- or                            , branch = '0.1.x',
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"goolord/alpha-nvim",
		init = function()
			vim.b.miniindentscope_disable = true
		end,

		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{ "lewis6991/gitsigns.nvim" },

	-- [[ LSP and Autocompletions: ]] --

	-- LSP and Formatting

	-- Autocompletion
	{
		"stevearc/conform.nvim",
		"mfussenegger/nvim-lint",
		"neovim/nvim-lspconfig",
	},
	{
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"hrsh7th/cmp-cmdline", -- for cmd auto complete
		"onsails/lspkind.nvim", -- for vscode like symbols for auto complete menu
	},

	--  [[ Themes: ]]      --

	{ "navarasu/onedark.nvim", event = "VimEnter" },

	-- [[ General Purpose: ]] --

	{
		"kylechui/nvim-surround",
		event = "InsertEnter",
		version = "main",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"utilyre/barbecue.nvim",
		event = "LspAttach",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "LspAttach",
		dependencies = {
			"kevinhwang91/promise-async",
			"luukvbaal/statuscol.nvim",
			"lewis6991/foldsigns.nvim",
		},
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
	},
	{
		"folke/trouble.nvim",
		branch = "main",
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	"folke/flash.nvim",
	"folke/zen-mode.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	"olimorris/persisted.nvim",
	"stevearc/dressing.nvim",
	"tpope/vim-commentary",
	"RRethy/vim-illuminate",

	-- [[ Indentation Guides: ]] --

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		init = function()
			vim.b.miniindentscope_disable = true
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}

require("lazy").setup(plugins, {
	install = {
		colorscheme = { "onedark" },
	},
	ui = {
		border = "rounded",
		title = " Lazy NVIM ",
		title_pos = "center",
	},
})

vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<CR>")
