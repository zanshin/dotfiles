-- My Mappings
-- August 4, 2025
--

-- Use semi-colon (;) for colon (:)
-- Use two semi-colons (;;) for semi-colon (;)
vim.keymap.set("n", ";", ":", { desc = "Map ; to be :" })
vim.keymap.set("n", ";;", ";", { desc = "Map ;; to be ;" })

-- Toggle relative numbering on or off
vim.keymap.set("n", "<leader>rn", function()
	vim.o.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle [R]elative line [N]umbers" })

-- Remove search highlighting
vim.keymap.set({ "n", "v", "i" }, "<Esc>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd("nohlsearch | redraw!")
	end
	return "<Esc>"
end, { desc = "Remove search highlighting", expr = true, silent = true })

-- Exit terminal mode with <ECC><ESC> instead of <c-\><c-n>
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Use <Tab> and <Shift><Tab> to navigate tabs
vim.keymap.set("n", "<Tab>", ":tabnext<cr>", { desc = "Go to next tab" })
vim.keymap.set("n", "<S-Tab>", ":tabprevious<cr>", { desc = "Go to previous tab" })

-- System clipboard
vim.keymap.set("v", "Y", '"+y', { desc = "[Y]ank to system clipboard in visual mode" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "[y]ank to system clipboard in normal mode" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "[p]aste from system clipboard in normal mode" })
vim.keymap.set("n", "<leader>d", '"+d', { desc = "[d]elete to system clipboard in normal mode" })

-- Use jq to format JSON
vim.keymap.set("n", "<leader>jq", ":%jq .<cr>", { desc = "Format JSON using jq" })

-- Sourcing things
vim.keymap.set("n", "<leader>x", "<cmd>.lua<cr>", { desc = "Execute the current line" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<cr>", { desc = "Execute the current file" })

-- Sudo to write protected file
vim.keymap.set("c", "w!!", "!sudo tee % > /dev/null", { desc = "Use sudo to write protected file" })

-- Git Blame
-- vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<cr>", { desc = 'Toggle Git [B]lame on / off' })

-- Git Signs
vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle [G]it [B]lame" })
