-- Notify
-- August 5, 2025
--

return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	opts = {
		render = "compact",
		timeout = 3000,
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify
	end,
}
