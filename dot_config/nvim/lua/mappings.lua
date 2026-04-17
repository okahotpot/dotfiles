require "nvchad.mappings"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- NAVIGATION & WINDOW MANAGEMENT
-- ============================================================================
-- NeoTree: reveal current file
map("n", "ec", ":Neotree reveal_file=<cfile> reveal_force_cwd<CR>", { desc = "NeoTree reveal current file" })

-- Window splitting
map("n", "ss", ":vsplit<Return>", opts)
map("n", "sv", ":split<Return>", opts)

-- Window navigation
map("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
map("n", "<leader>wj", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<leader>wk", "<C-w>k", { desc = "Move to top window" })
map("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })
map("n", "<leader>ww", "<cmd>bdelete<CR>",  { desc = "Close current buffer" })
map("n", "<leader>wd", "<cmd>bdelete!<CR>", { desc = "Close buffer (discard changes)" })
map("n", "<leader>ws", "<cmd>w | bdelete<CR>", { desc = "Save and close buffer" })

-- ============================================================================
-- BUFFER MANAGEMENT (<leader>b)
-- ============================================================================
map("n", "<leader>bd", "<cmd>bdelete<CR>",         { desc = "Delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>",            { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>",        { desc = "Prev buffer" })
map("n", "<leader>ba", "<cmd>bufdo bdelete<CR>",    { desc = "Delete all buffers" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>",       { desc = "Delete other buffers" })
map("n", "<leader>bl", function()
  require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = false })
end, { desc = "List open buffers" })
map("n", "<leader>bb", "<cmd>e #<CR>",              { desc = "Switch to previous buffer" })

-- ============================================================================
-- GIT (<leader>g)
-- ============================================================================
map("n", "<leader>gg", "<cmd>LazyGit<CR>",          { desc = "LazyGit" })

-- Gitsigns hunks
map("n", "<leader>gj", function() require("gitsigns").next_hunk() end,        { desc = "Next hunk" })
map("n", "<leader>gk", function() require("gitsigns").prev_hunk() end,        { desc = "Prev hunk" })
map("n", "<leader>gs", function() require("gitsigns").stage_hunk() end,       { desc = "Stage hunk" })
map("n", "<leader>gr", function() require("gitsigns").reset_hunk() end,       { desc = "Reset hunk" })
map("n", "<leader>gS", function() require("gitsigns").stage_buffer() end,     { desc = "Stage buffer" })
map("n", "<leader>gR", function() require("gitsigns").reset_buffer() end,     { desc = "Reset buffer" })
map("n", "<leader>gp", function() require("gitsigns").preview_hunk() end,     { desc = "Preview hunk" })
map("n", "<leader>gb", function() require("gitsigns").blame_line() end,       { desc = "Blame line" })
map("n", "<leader>gd", function() require("gitsigns").diffthis() end,         { desc = "Diff this" })
map("n", "<leader>gD", function() require("gitsigns").diffthis("~") end,      { desc = "Diff this ~" })
map("n", "<leader>gtb", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle blame" })
map("n", "<leader>gtd", function() require("gitsigns").toggle_deleted() end,  { desc = "Toggle deleted" })

-- Find files
map("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>/", "<cmd>Telescope live_grep<CR>", { desc = "Find in all files" })

-- Jump list picker
map("n", "<leader>jj", "<cmd>Telescope jumplist<CR>", { desc = "Jumplist" })

-- Jump list (safe: swallows invalid mark errors)
map("n", "<C-o>", function()
  pcall(function() vim.cmd "normal! \x0f" end)
end, { desc = "Jump back in jumplist" })

map("n", "<C-p>", function()
  pcall(function() vim.cmd "normal! \x09" end)
end, { desc = "Jump forward in jumplist" })

-- Treewalker: AST-aware left/right navigation
vim.api.nvim_set_keymap("n", "<C-h>", ":Treewalker Left<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":Treewalker Right<CR>", { noremap = true, silent = true })

-- ============================================================================
-- TEXT EDITING & MANIPULATION
-- ============================================================================
-- Insert blank lines without entering insert mode
map("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>k", { desc = "Add blank line above" })
map("n", "go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>j", { desc = "Add blank line below" })

-- Search and replace word under cursor
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", { desc = "Search and replace word under cursor" })

-- c/d use black hole register (don't clobber yank register)
map("n", "c", '"_c', opts)
map("n", "C", '"_C', opts)
map("x", "c", '"_c', opts)
map("x", "C", '"_C', opts)
map("n", "d", '"_d', opts)
map("n", "D", '"_D', opts)
map("x", "d", '"_d', opts)
map("x", "D", '"_D', opts)

-- Wrap word in quotes
map("n", "ca'", "ciw'<c-r>\"'<esc>", { desc = "Wrap word in single quotes" })
map("n", 'ca"', 'ciw"<c-r>""<esc>', { desc = "Wrap word in double quotes" })

-- ============================================================================
-- CODE REFACTORING
-- ============================================================================
map("x", "<leader>re", ":Refactor extract ", { desc = "Extract" })
map("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Extract to file" })
map("x", "<leader>rv", ":Refactor extract_var ", { desc = "Extract variable" })
map({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Inline variable" })
map("n", "<leader>rI", ":Refactor inline_func", { desc = "Inline function" })
map("n", "<leader>rb", ":Refactor extract_block", { desc = "Extract block" })
map("n", "<leader>rbf", ":Refactor extract_block_to_file", { desc = "Extract block to file" })

-- ============================================================================
-- PACKAGE INFO (npm)
-- ============================================================================
map("n", "<leader>cpt", "<cmd>lua require('package-info').toggle()<cr>", { silent = true, noremap = true, desc = "Toggle package info" })
map("n", "<leader>cpd", "<cmd>lua require('package-info').delete()<cr>", { silent = true, noremap = true, desc = "Delete package" })
map("n", "<leader>cpu", "<cmd>lua require('package-info').update()<cr>", { silent = true, noremap = true, desc = "Update package" })
map("n", "<leader>cpi", "<cmd>lua require('package-info').install()<cr>", { silent = true, noremap = true, desc = "Install package" })
map("n", "<leader>cpc", "<cmd>lua require('package-info').change_version()<cr>", { silent = true, noremap = true, desc = "Change package version" })

-- ============================================================================
-- NOICE (notifications)
-- ============================================================================
map("n", "<leader>nl", function() require("noice").cmd "last" end, { desc = "Noice last message" })
map("n", "<leader>nh", function() require("noice").cmd "history" end, { desc = "Noice message history" })

-- ============================================================================
-- TEST RUNNER (Telescope fuzzy find + npm test)
-- ============================================================================
map("n", "<leader>tt", function()
  require("telescope.builtin").find_files {
    prompt_title = "Run Test",
    search_dirs = { "src" },
    find_command = { "fd", "-e", "ts", "-i", "test" },
    attach_mappings = function(_, tmap)
      tmap("i", "<CR>", function(prompt_bufnr)
        local entry = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(prompt_bufnr)
        vim.cmd("split | terminal npm test -- --runTestsByPath " .. entry.path)
      end)
      tmap("n", "<CR>", function(prompt_bufnr)
        local entry = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(prompt_bufnr)
        vim.cmd("split | terminal npm test -- --runTestsByPath " .. entry.path)
      end)
      return true
    end,
  }
end, { desc = "Fuzzy find and run test file" })

-- ============================================================================
-- LSP REFERENCES
-- ============================================================================
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references (Telescope)" })
map("n", "gR", function()
  vim.lsp.buf.references(nil, { loclist = true })
  vim.cmd "lopen"
end, { desc = "LSP references (location list)" })

-- ============================================================================
-- QUIT / SAVE (<leader>q)
-- ============================================================================
map("n", "<leader>qd", "<cmd>qa!<CR>", { desc = "Quit all without saving" })
map("n", "<leader>qw", "<cmd>wqa<CR>", { desc = "Write all and quit" })

-- ============================================================================
-- MISC UTILITIES
-- ============================================================================
-- Additional escape mappings
map({ "i", "v" }, "<C-[>", "<Esc>", { noremap = true })
map("i", "jk", "<Esc>", { noremap = true, desc = "jk to escape" })

-- Exit terminal mode with Esc
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode" })

-- Smart q: kill terminal process or quit buffer
map("n", "q", function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
    local ok, job_id = pcall(vim.api.nvim_buf_get_var, buf, "terminal_job_id")
    if ok and job_id and job_id > 0 then
      vim.api.nvim_chan_send(job_id, "\003")
      vim.defer_fn(function()
        vim.api.nvim_chan_send(job_id, "\003")
        vim.defer_fn(function() vim.cmd "bdelete!" end, 50)
      end, 100)
    else
      vim.cmd "bdelete!"
    end
  else
    vim.cmd "quit"
  end
end, { desc = "Smart quit (kills terminal processes)" })
