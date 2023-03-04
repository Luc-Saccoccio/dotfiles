local neorg = require('neorg')

neorg.setup {
	load = {
		["core.defaults"] = {},
		["core.keybinds"] = {
			config = {
				default_keybinds = true,
			}
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					work = "~/notes/work",
					home = "~/notes/home",
					scp  = "~/notes/scp",
				}
			}
		},
		["core.norg.concealer"] = {},
		["core.integrations.telescope"] = {},
	}
}
