-- require('auto-session').setup({
-- 	auto_session_enable_last_session = true,
-- 	auto_restore_enabled = false,
-- 	auto_save_enabled = true,
-- 	auto_session_create_enabled = true,
-- 	auto_session_suppress_dirs = { "~/Projects", "~/Downloads", "~/Desktop" },
-- 	auto_session_use_git_branch = true,
-- 	session_lens = {
-- 		-- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
-- 		buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
-- 		load_on_setup = true,
-- 		theme_conf = { border = true, winblend = 0 },
-- 		previewer = false,
-- 	},
-- 	cwd_change_handling = {
-- 		restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
-- 		pre_cwd_changed_hook = nil,  -- already the default, no need to specify like this, only here as an example
-- 		post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
-- 			require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
-- 		end,
-- 	},
-- 	-- pre_save_cmds = {
-- 	-- 	"Neotree close",
-- 	-- },
-- 	post_restore_cmds = {
-- 		require("neo-tree.command").execute({
-- 			toggle = true,
-- 			dir = vim.fn.getcwd()
-- 		})
-- 	},
-- })

-- vim.keymap.set("n", "<leader>ss", require('auto-session.session-lens').search_session, { noremap = true })
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"