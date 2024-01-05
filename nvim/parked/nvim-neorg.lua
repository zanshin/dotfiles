local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
  vim.notify("neorgnot available.")
  return
end

neorg.setup {
  load = {
    ["core.defaults"] = {}, -- loads default behaviors
    ["core.concealer"] = {}, -- adds pretty icons to your documents
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Documents/notes",
        },
      },
    },
  },
}
