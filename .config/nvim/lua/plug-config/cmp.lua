local cmp = require('cmp')
local luasnip = require('luasnip')
local mapping = require('cmp.config.mapping')

vim.g.cmp_enabled = true

cmp.setup {
	enabled = function()
		return vim.g.cmp_enabled
	end,
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snip]",
				buffer = "[Buffer]",
			})[entry.source.name]
			return vim_item
		end,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<Tab>'] = mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, {'i'}),
		['<S-Tab>'] = mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {'i'}),
		['<C-e>'] = mapping(cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		}), {'i'}),
	},
	sources = cmp.config.sources {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{
			name = 'buffer',
			option = {
				keyword_pattern = [[\k\+]],
			},
		},
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	}
}

require("luasnip/loaders/from_vscode").lazy_load()
