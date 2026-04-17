return {
  -- Telescope: case-insensitive search by default
  {
    "nvim-telescope/telescope.nvim",
    opts = require "configs.telescope",
  },

  -- File explorer (replaces nvim-tree)
  { "nvim-tree/nvim-tree.lua", enabled = false },

  -- Yazi: floating file explorer
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    keys = {
      { "<leader>E",  "<cmd>Yazi<cr>",        mode = { "n", "v" }, desc = "Yazi (current file)" },
      { "<leader>ey", "<cmd>Yazi cwd<cr>",    desc = "Yazi (cwd)" },
      { "<leader>er", "<cmd>Yazi toggle<cr>", desc = "Yazi (resume last)" },
    },
    opts = {
      yazi_floating_window_border = "rounded",
    },
  },

  -- Neo-tree: sidebar file explorer (default on startup)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    },
    opts = require "configs.neo-tree",
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then
            vim.cmd "Neotree show"
          end
        end,
      })
    end,
  },

  -- Buffer jump menu
  {
    "leath-dub/snipe.nvim",
    keys = {
      {
        "ww",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
      current_win_only = true,
      ui = {
        position = "center",
        open_win_override = {
          title = "JumpList",
          border = "rounded",
        },
      },
      hint = { dictionary = "aflewcmpghio" },
      navigate = {
        close_buffer = "d",
        open_split = "s",
      },
    },
  },

  -- Find and replace
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {},
  },

  -- Enhanced motion
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- Diagnostics list
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- TODO/FIXME highlights
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Refactoring operations
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>re", mode = "x" },
      { "<leader>rf", mode = "x" },
      { "<leader>rv", mode = "x" },
      { "<leader>ri", mode = { "n", "x" } },
      { "<leader>rI", mode = "n" },
      { "<leader>rb", mode = "n" },
      { "<leader>rbf", mode = "n" },
    },
    config = function()
      require("refactoring").setup()
    end,
  },

  -- Multi-cursor
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },

  -- Increment/decrement
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
  },

  -- Surround text objects
  {
    "tpope/vim-surround",
    event = "BufReadPost",
  },

  -- Move lines/blocks (H/L/J/K in visual mode)
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        left = "H",
        right = "L",
        down = "J",
        up = "K",
        line_left = "",
        line_right = "",
        line_down = "",
        line_up = "",
      },
    },
  },

  -- AST-based navigation
  {
    "aaronik/treewalker.nvim",
    event = "VeryLazy",
    opts = { highlight = true },
  },

  -- Code outline (with aerial integration)
  {
    "hedyhli/outline.nvim",
    cmd = "Outline",
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle Outline" },
    },
    config = function()
      require("outline").setup {}
    end,
  },

  -- Aerial (symbol nav: { / })
  {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("aerial").setup {
        on_attach = function(bufnr)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      }
    end,
  },

  -- Auto-close unused buffers (threshold 10)
  {
    "axkirillov/hbac.nvim",
    event = "VeryLazy",
    opts = {
      autoclose = true,
      threshold = 10,
      close_command = function(bufnr)
        vim.api.nvim_buf_delete(bufnr, {})
      end,
      close_buffers_with_windows = false,
    },
  },

  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Git signs + hunk actions
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
    },
  },

  -- Session management
  {
    "folke/persistence.nvim",
    lazy = false,
    opts = {},
    config = function(_, opts)
      require("persistence").setup(opts)
      -- Auto-restore session when opening nvim with no file args in a repo directory
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        once = true,
        callback = function()
          if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
            require("persistence").load()
          end
        end,
      })
    end,
    keys = {
      { "<leader>ps", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>pl", function() require("persistence").load { last = true } end, desc = "Restore Last Session" },
      { "<leader>pd", function() require("persistence").stop() end, desc = "Don't Save Session" },
    },
  },
}
