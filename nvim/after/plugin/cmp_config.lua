local cmp = require('cmp')
local lspkind = require('lspkind')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

--- Function to preview snippet before completion with nvim-cmp
---@param entry cmp.Entry
---@param vim_item vim.CompletedItem
---@return vim.CompletedItem
function CmpBefore(entry, vim_item)
	if entry.completion_item.snippet then
		local snippet_value = entry.completion_item.snippet.value
		local parsed_snippet = vim.lsp.util.parse_snippet(snippet_value)
		local snippet_preview = str.oneline(str.oneline(parsed_snippet))
		vim_item.abbr = snippet_preview
	else
		vim_item.abbr = entry:get_insert_text()
	end
	return vim_item
end

-- basic autocomplete
cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
	},

	window = {
		--completion = cmp.config.window.bordered(),
		--documentation = cmp.config.window.bordered(),

		documentation = {
			scrollbar = '|',
			max_height = 15,
			max_width = 60,
			winhighlight = 'Normal:CmpPmenu,Search:None,CursorLine:Pmenu,CmpBorder:DiagnosticSignInfo', -- border will be the same as border of Noice cmdline_popup
			border = {
				{ "╭", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╮", "CmpBorder" },
				{ "│", "CmpBorder" },
				{ "╯", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╰", "CmpBorder" },
				{ "│", "CmpBorder" },
			}
		},

		completion = {
			col_offset = 0,
			side_padding = 1,
			scrollbar = '|',
			winhighlight = 'Normal:CmpPmenu,CursorLine:Visual,Search:None,CmpBorder:DiagnosticSignInfo', -- border will be the same as border of Noice cmdline_popup
			border = {
				{ "╭", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╮", "CmpBorder" },
				{ "│", "CmpBorder" },
				{ "╯", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╰", "CmpBorder" },
				{ "│", "CmpBorder" },
			}
		},
	},
	-- preselect the first item in the list
	preselect = 'item',
	completion = {
		completeopt = 'menu,menuone,preview,noinsert'
	},

	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- can also be a function to dynamically calculate max width such as
			-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			show_labelDetails = true, -- show labelDetails in menu. Disabled by default

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = CmpBefore,

			symbol_map = {
				Text = "", --
				Method = "", --
				Function = "", --
				Constructor = "󱁤",
				Field = "",
				Variable = "󰀫󰂡",
				Class = "󰠱", --
				Interface = "", --
				Module = "", --
				Property = "",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "",
				File = "󰈔",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿", -- 
				Struct = "",
				Event = "", --
				Operator = "󰆕",
				TypeParameter = "",
			}
		})
	},

	mapping = cmp.mapping.preset.insert({
		-- Enter key confirms completion item
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
		-- Ctrl + Space opens completion menj
		['<C-Space>'] = cmp.mapping.complete(),
		-- Ctrl + e closes completion menu
		['<C-e>'] = cmp.mapping.abort(),
		['<C-j>'] = {
			i = function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = require("cmp.types").cmp.SelectBehavior.Insert })
				else
					cmp.complete()
				end
			end,
		},
		['<C-k>'] = {
			i = function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = require("cmp.types").cmp.SelectBehavior.Insert })
				else
					cmp.complete()
				end
			end,
		},
	}),

	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},


	experimental = {
		ghost_text = true,
	},

	performance = {
		max_view_entries = 15
	}
})

-- autocomplete for command line
--`/` cmdline setup.
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline({
		['<Tab>'] = cmp.mapping.confirm({ select = true })
	}),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{
			name = 'cmdline',
			option = {
				ignore_cmds = { 'Man', '!' }
			}
		}
	}),
	window = {
		completion = {
			scrollbar = '|',
		}
	}
})

-- config for autopairs.
cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)
