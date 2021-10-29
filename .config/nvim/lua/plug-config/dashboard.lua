vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_custom_section = {
	last_session = {
		description = { " Load Last Session" },
		command = "SessionLoad",
	},
	newfile = {
		description = { " New File" },
		command = "DashboardNewFile",
	},
	findfile = {
		description = { " Find File" },
		command = "DashboardFindFile",
	},
	history = {
		description = { " History" },
		command = "DashboardFindHistory",
	},
	file_explorer = {
		description = { " Open File Explorer" },
		command = "NvimTreeOpen",
	},
	zedit_config = {
		description = { " Edit config" },
		command = "Telescope fd cwd=$HOME/.config/nvim/",
	},
}

-- Set autosave last session
vim.cmd("autocmd BufWritePost * silent! SessionSave")
vim.g.dashboard_custom_header = require("headers")
math.randomseed(os.time())

local footers = {
	"Komm, süsser Tod",
	"Qu'as-tu donné à la cité Montag ? Des cendres. Que se sont donnés entre eux les autres ? Le néant.",
	"Ce n'était que des masques dérisoires appliqués sur des pensées infectes et les voix essayaient en vain de dominer le profond silence dans chaque poitrine.",
	"Some have chocolate, others have Jesus. Some have Bouddha. We have buffalos",
	"J\'avais raison, le réel s\'est trompé",
	"The interaction of men and women isn't very logical.",
	"Long is The Night",
	"Le C.R.O.U. initial choisit la prose et l'hypnose. Bannir les chiens, telle est notre cause.",
	"We'll fight the sun and have our fun until the night is gone. So wipe the tears from your face and roll the night away.",
	"Never Knows Best",
	"Ou L’Art Délicat De Passer Pour Un Con",
	"Do one thing, do it well - Unix philosophy",
}

local randomize = math.random(#footers)
vim.g.dashboard_custom_footer = { footers[randomize] }
-- vim.g.dashboard_custom_footer = { footers[10] }
