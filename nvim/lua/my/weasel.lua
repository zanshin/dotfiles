local weasel_pattern =
	[[\v<(many|various|very|fairly|several|extremely|exceedingly|quite|remarkably|few|surprisingly|mostly|largely|huge|tiny|excellent|interestingly|significantly|substantially|clearly|vast|relatively|completely)>|<(are|is)\s+a\s+number>]]

local weasel_ns = vim.api.nvim_create_namespace("weasel_words")

vim.api.nvim_set_hl(0, "WeaselWords", {
	fg = "#ff0000",
	bold = true,
	underline = true,
})

-- Track which buffers have weasel highlighting enabled
local enabled_bufs = {}

local function enable_weasel(bufnr)
	enabled_bufs[bufnr] = true
	vim.fn.matchadd("WeaselWords", weasel_pattern)
end

local function disable_weasel(bufnr)
	enabled_bufs[bufnr] = nil
	for _, match in ipairs(vim.fn.getmatches()) do
		if match.group == "WeaselWords" then
			vim.fn.matchdelete(match.id)
		end
	end
end

local function toggle_weasel()
	local bufnr = vim.api.nvim_get_current_buf()
	if enabled_bufs[bufnr] then
		disable_weasel(bufnr)
		vim.notify("Weasel words off", vim.log.levels.INFO)
	else
		enable_weasel(bufnr)
		vim.notify("Weasel words on", vim.log.levels.INFO)
	end
end

-- Re-apply in each new window that opens the buffer
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("weasel-words", { clear = true }),
	callback = function(args)
		if enabled_bufs[args.buf] then
			local already = false
			for _, match in ipairs(vim.fn.getmatches()) do
				if match.group == "WeaselWords" then
					already = true
					break
				end
			end
			if not already then
				vim.fn.matchadd("WeaselWords", weasel_pattern)
			end
		end
	end,
})

-- Auto-enable for prose filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("weasel-words-ft", { clear = true }),
	pattern = { "markdown", "text", "rst", "asciidoc" },
	callback = function(args)
		vim.schedule(function()
			enabled_bufs[args.buf] = true
			vim.fn.matchadd("WeaselWords", weasel_pattern)
		end)
	end,
})

vim.api.nvim_create_user_command("ToggleWeaselWords", toggle_weasel, {})
vim.keymap.set("n", "<leader>tw", toggle_weasel, { desc = "Toggle weasel word highlighting" })
