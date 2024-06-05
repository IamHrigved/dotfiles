local DiagnosticSigns = vim.g.DiagnosticSigns
DiagnosticSigns["priority"] = 10 -- NEVER CHANGE see gitsigns.lua

vim.keymap.set("n", "er", "<cmd>lua vim.diagnostic.open_float()<cr>") -- 'er' for popup and dg for telescope
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

-- default lsp config
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		-- these will be buffer-local keybindings
		-- because they only work if you have an active language server

		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts) in telescope.lua
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts) in telescope.lua
		vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<leader>fm", require("conform").format, opts)
		vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		vim.keymap.set(
			"n",
			"<leader>ih",
			"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
			opts
		)
	end,
})

vim.diagnostic.config({
	signs = DiagnosticSigns,
	severity_sort = true,
	underline = true,
	virtual_lines = true,
	update_in_insert = false,
	float = {
		-- UI.
		header = "Diagnostics:",
		border = "rounded",
		focusable = true,
	},
	virtual_text = {
		spacing = 4,
		source = "if_many",
		-- prefix = "●",
		-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
		-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
		-- prefix = function(diagnostic)
		-- 	if diagnostic.severity == vim.diagnostic.severity.ERROR then
		-- 		return DiagnosticSigns["Error"]
		-- 	elseif diagnostic.severity == vim.diagnostic.severity.WARN then
		-- 		return DiagnosticSigns["Warn"]
		-- 	elseif diagnostic.severity == vim.diagnostic.severity.INFO then
		-- 		return DiagnosticSigns["Info"]
		-- 	else
		-- 		return DiagnosticSigns["Hint"]
		-- 	end
		-- end,
	},
})

-- default capabilities and on_attatch functions:
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
lsp_capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local default_on_attach = function(client, bufnr)
	print("Welcome to " .. vim.bo.filetype .. " programing!")
	vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end
end

-- defalt setup for differenet lsp's
local default_setup = function(server, opts)
	local default_opts = {
		capabilities = lsp_capabilities,
		on_attach = default_on_attach,
	}
	for k, v in pairs(opts) do
		default_opts[k] = v
	end
	require("lspconfig")[server].setup(default_opts)
end

-- configuring all lsp's
default_setup("lua_ls", {})

default_setup("marksman", {})

default_setup("clangd", {})

default_setup("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
})
