local nvim_comment_status_ok, nvim_comment = pcall(require, "nvim_comment")
if not nvim_comment_status_ok then
  return
end

nvim_comment.setup()
-- nvim_comment.setup {
--   marker_padding = true,      -- Linters prefer comment and line to have a space in between markers
--   comment_empty = true,       -- should comment out empty or whitespace only lines
--   create_mappings = true,     -- Should key mappings be created
--   line_mapping = "gcc",       -- Normal mode mapping left hand side
--   operator_mapping = "gc",    -- Visual/Operator mapping left hand side
--   hook = nil                  -- Hook function to call before commenting takes place
-- }
