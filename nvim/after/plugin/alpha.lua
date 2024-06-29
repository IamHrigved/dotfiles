local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local lazy = require("lazy")

dashboard.section.buttons.val = {
	dashboard.button("f", "󰱼   Find file", ":Telescope find_files <CR>"),
	dashboard.button("o", "󱋡   Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("r", "   Open last session", ":SessionLoadLast<CR>"),
	dashboard.button("z", "󰋚   Search Zoxide", ":Telescope zoxide list<CR>"),
	dashboard.button("t", "󰊄   Find text", ":Telescope live_grep <CR>"),
	dashboard.button("l", "󰒲   Open Lazy", ":Lazy <CR>"),
	dashboard.button("c", "   Configuration", ":bd <BAR> :Neotree dir=~/.config/nvim <CR>"),
	dashboard.button("q", "󰿅   Quit Neovim", ":qa<CR>"),
}

local datetime = os.date(" %d-%m-%Y    %H:%M:%S")

local header1 = {
	"                                                     ",
	"  ███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ ",
	"  ████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ ",
	"  ██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ ",
	"  ██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ",
	"  ██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ",
	"  ╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ",
	"                                                     ",
	[[                   ]] .. datetime .. [[  ]],
}
local header2 = {

	" ███▄    █ ▓█████  ▒█████   ██▒   █  ██▓ ███▄ ▄███▓   ",
	" ██ ▀█   █ ▓█   ▀ ▒██▒  ██ ▓██░   █ ▓██▒ ██▒▀█▀ ██▒   ",
	"▓██  ▀█ ██ ▒███   ▒██░  ██▒ ▓██  ██ ▒██▒ ██    ▓██░   ",
	"▓██▒  ▐▌██ ▒▓█  ▄ ▒██   ██░  ▒██ █▒░░██░ ██    ▒██    ",
	"▒██░   ▓██ ░▒████ ░ ████▓▒░   ▒▀█░  ░██  ██▒   ░██▒  ",
	"░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓ ░ ▒░    ░  ░   ",
	"░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░ ░       ░   ",
	"   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░      ",
	"         ░    ░  ░    ░ ░        ░   ░         ░      ",
	"                                ░                     ",
}
local header3 = {
	type = "text",
	val = {
		[[                                                                   ]],
		[[      ████ ██████           █████      ██                    ]],
		[[     ███████████             █████                            ]],
		[[     █████████ ███████████████████ ███   ███████████  ]],
		[[    █████████  ███    █████████████ █████ ██████████████  ]],
		[[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
		[[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
		[[██████  █████████████████████ ████ █████ █████ ████ ██████]],
		[[]],
		[[                          ]] .. datetime .. [[  ]],
	},
	opts = {
		position = "center",
		hl = "TSRainbowBlue",
		wrap = "overflow",
	},
}

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimStarted",
	callback = function()
		local stats = lazy.stats()
		local count = (math.floor(stats.startuptime * 100) / 100)
		local version = vim.version()
		local nvim_version_info = "  󰋼 v" .. version.major .. "." .. version.minor .. "." .. version.patch
		dashboard.section.footer.val = {
			"󱐋 " .. stats.count .. " plugins loaded in " .. count .. " ms",
			"       NeoVim " .. nvim_version_info,
		}
		pcall(vim.cmd.AlphaRedraw)
	end,
})

--local alpha_on_empty = vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
--vim.api.nvim_create_aucmd("User", {
--	pattern = "BDeletePost*",
--	group = alpha_on_empty,
--	callback = function(event)
--		local fallback_name = vim.api.nvim_buf_get_name(event.buf)
--		local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
--		local fallback_on_empty = fallback_name == "" and fallback_ft == ""
--
--		if fallback_on_empty then
--			require("neo-tree").close_all()
--			vim.cmd("Alpha")
--			vim.cmd(event.buf .. "bwipeout")
--		end
--	end,
--})

-- dashboard.section.header = header3
dashboard.section.header.val = header1

dashboard.config.opts = {
	noautocmd = true,
}

alpha.setup(dashboard.config)
