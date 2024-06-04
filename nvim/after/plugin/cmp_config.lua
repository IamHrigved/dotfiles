local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

--- Function to preview snippet before completion with nvim-cmp
function CmpBefore(entry, vim_item)
	if entry.completion_item.snippet then
		local snippet_value = entry.completion_item.snippet.value
		local parsed_snippet = vim.lsp.util.parse_snippet(snippet_value)
		local snippet_preview = str.oneline(str.oneline(parsed_snippet))
		vim_item.abbr = snippet_preview
	elseif #vim_item.abbr > 15 then
		vim_item.abbr = string.sub(vim_item.abbr, 1, 20) .. "..."
	end
	if vim_item.menu ~= nil then
		if #vim_item.menu > 12 then
			vim_item.menu = string.sub(vim_item.menu, 1, 12) .. "..."
		end
	end
	return vim_item
end

local lspKindFormat = lspkind.cmp_format({
	mode = "symbol_text", -- show only symbol annotations
	maxwidth = 20, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
	-- can also be a function to dynamically calculate max width such as
	-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
	ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
	show_labelDetails = false, -- show labelDetails in menu. Disabled by default

	-- The function below will be called before any actual modifications from lspkind
	-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
	before = CmpBefore,

	symbol_map = {
		Text = "", --
		Method = "", --
		Function = "", --
		Constructor = "󱁤",
		Field = "󰜢",
		Variable = "󰀫󰂡",
		Class = "󰠱", --
		Interface = "", --
		Module = "", --
		Property = "",
		Unit = "",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "",
		File = "󰈙",
		Reference = "",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰏿", -- 
		Struct = "󰙅",
		Event = "", --
		Operator = "󰆕",
		TypeParameter = "",
	},
})
-- basic autocomplete
cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	},

	window = {
		--completion = cmp.config.window.bordered(),
		--documentation = cmp.config.window.bordered(),

		documentation = {
			scrollbar = "|",
			max_height = 15,
			max_width = 60,
			winhighlight = "Normal:CmpPmenu,Search:None,CursorLine:Pmenu,CmpBorder:DiagnosticSignInfo", -- border will be the same as border of Noice cmdline_popup
			border = {
				{ "╭", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╮", "CmpBorder" },
				{ "│", "CmpBorder" },
				{ "╯", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╰", "CmpBorder" },
				{ "│", "CmpBorder" },
			},
		},

		completion = {
			col_offset = 0,
			side_padding = 1,
			scrollbar = "|",
			winhighlight = "Normal:CmpPmenu,CursorLine:Visual,Search:None,CmpBorder:DiagnosticSignInfo", -- border will be the same as border of Noice cmdline_popup
			border = {
				{ "╭", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╮", "CmpBorder" },
				{ "│", "CmpBorder" },
				{ "╯", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╰", "CmpBorder" },
				{ "│", "CmpBorder" },
			},
		},
	},
	-- preselect the first item in the list
	preselect = "item",
	completion = {
		completeopt = "menu,menuone,preview,noinsert",
	},
	formatting = {
		fields = { "abbr", "menu", "kind" },
		-- format = lspKindFormat,
		format = function(entry, vim_item)
			local item = lspKindFormat(entry, vim_item)
			item.kind = item.kind .. " "
			return item
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
	}),

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	experimental = {
		ghost_text = true,
	},

	performance = {
		max_view_entries = 15,
	},
})

-- autocomplete for command line
--`/` cmdline setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline({
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
	window = {
		completion = {
			scrollbar = "|",
		},
	},
})

-- config for autopairs.
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local default = {
	-- if you change or add symbol here
	-- replace corresponding line in readme
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰜢",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "",
}
