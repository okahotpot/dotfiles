require "nvchad.options"

local opt = vim.opt

opt.relativenumber = false
opt.conceallevel = 0
opt.swapfile = false

-- Clipboard: yank syncs to system clipboard; c/d use black hole reg (via mappings)
opt.clipboard = "unnamedplus"

-- GUI font
opt.guifont = "FiraCode Nerd Font Mono:h12"

-- Global vars
vim.g.root_spec = { "cwd" }
vim.g.omni_sql_no_default_maps = 1
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.neo_tree_remove_legacy_commands = 1
