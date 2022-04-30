-- luasnip
local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end


luasnip.loaders.from_vscode.lazy_load()
