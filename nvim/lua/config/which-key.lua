local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

which_key.setup()
