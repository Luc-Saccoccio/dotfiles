local cmp = require('cmp')
local mapping = require('cmp.config.mapping')

vim.g.cmp_enabled = true

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

return {
      enabled = function()
    return vim.g.cmp_enabled
      end,
      window = {
    completion = {
        border = border("CmpBorder"),
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
        border = border("CmpDocBorder")
    }
      },
      formatting = {
    format = function(entry, vim_item)
        vim_item.menu = ({
      nvim_lsp = "[LSP]",
      buffer = "[Buffer]",
        })[entry.source.name]
        return vim_item
    end,
      },
      mapping = {
    ['<Tab>'] = mapping(function(fallback)
        if cmp.visible() then
      cmp.select_next_item()
        else
      fallback()
        end
    end, {'i'}),
    ['<S-Tab>'] = mapping(function(fallback)
        if cmp.visible() then
      cmp.select_prev_item()
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
    {
        name = 'buffer',
        option = {
      keyword_pattern = [[\k\+]],
        },
    },
    { name = 'snippy' },
      },
      snippet = {
      expand = function(args)
        require('snippy').expand_snippet(args.body)
      end,
      },
      experimental = {
    native_menu = false,
    ghost_text = true,
      }
}
