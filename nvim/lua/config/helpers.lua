local M = {}

-- Helper function to set same keymap for multiple modes
function M.set_keymap_multi_mode(modes, lhs, rhs, opts)
  -- If modes is a string, convert it to a table
  if type(modes) == "string" then
    modes = { modes }
  end
  -- Set keymap for each mode
  for _, mode in ipairs(modes) do
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
