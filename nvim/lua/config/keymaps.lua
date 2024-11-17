-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local helper = require("config.helpers")

keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true }) -- Borderless terminal vim.keymap.set("n", "<C-/>", function() Util.terminal(nil, { border = "none" }) end, { desc = "Term with border" }) -- Borderless lazygit vim.keymap.set("n", "<leader>gg", function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false, border = "none" }) end, { desc = "Lazygit (root dir)" }) keymap.del({ "n", "i", "v" }, "<A-j>")
keymap.del({ "n", "i", "v" }, "<A-k>")
keymap.del("n", "<C-Left>")
keymap.del("n", "<C-Down>")
keymap.del("n", "<C-Up>")
keymap.del("n", "<C-Right>")

keymap.set("n", "<M-h>", '<Cmd>lua require("tmux").resize_left()<CR>', { silent = true })
keymap.set("n", "<M-j>", '<Cmd>lua require("tmux").resize_bottom()<CR>', { silent = true })
keymap.set("n", "<M-k>", '<Cmd>lua require("tmux").resize_top()<CR>', { silent = true })
keymap.set("n", "<M-l>", '<Cmd>lua require("tmux").resize_right()<CR>', { silent = true })

local set_keymap = vim.api.nvim_set_keymap

-- Split windows
keymap.set("n", "ss", ":vsplit<Return>", opts)
keymap.set("n", "sv", ":split<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- package-info keymaps
set_keymap(
  "n",
  "<leader>cpt",
  "<cmd>lua require('package-info').toggle()<cr>",
  { silent = true, noremap = true, desc = "Toggle" }
)
set_keymap(
  "n",
  "<leader>cpd",
  "<cmd>lua require('package-info').delete()<cr>",
  { silent = true, noremap = true, desc = "Delete package" }
)
set_keymap(
  "n",
  "<leader>cpu",
  "<cmd>lua require('package-info').update()<cr>",
  { silent = true, noremap = true, desc = "Update package" }
)
set_keymap(
  "n",
  "<leader>cpi",
  "<cmd>lua require('package-info').install()<cr>",
  { silent = true, noremap = true, desc = "Install package" }
)
set_keymap(
  "n",
  "<leader>cpc",
  "<cmd>lua require('package-info').change_version()<cr>",
  { silent = true, noremap = true, desc = "Change package version" }
)
vim.keymap.set("n", "<leader>nl", function()
  require("noice").cmd("last")
end)

vim.keymap.set("n", "<leader>nh", function()
  require("noice").cmd("history")
end)

-- add insert without going into insert mode
vim.keymap.set(
  "n",
  "gO",
  "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>k",
  { desc = "Add new line underneath" }
)

vim.keymap.set(
  "n",
  "go",
  "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>j",
  { desc = "Add new line above" }
)
-- make delete operations use "dd register to not conflict with yanking
helper.set_keymap_multi_mode({ "n", "v" }, "d", '"dd', opts)
helper.set_keymap_multi_mode("n", "D", '"dD', opts)
helper.set_keymap_multi_mode("n", "dd", '"ddd', opts)

--refactoring
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

vim.keymap.set({ "n", "x" }, "<leader>rr", function()
  require("telescope").extensions.refactoring.refactors()
end)

-- add quotes
vim.keymap.set("n", "ca'", "ciw'<c-r>\"'<esc>", { desc = "Add single quotes to word" })
vim.keymap.set("n", 'ca"', 'ciw"<c-r>""<esc>', { desc = "Add double quotes to word" })
