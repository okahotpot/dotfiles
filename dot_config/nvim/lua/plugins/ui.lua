return {
  -- Dashboard / welcome screen
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
      theme = "hyper",
      config = {
        header = {
          "",
          "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
          "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
          "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
          "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
          "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
          "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
          "",
        },
        shortcut = {
          {
            icon = "󰊳 ",
            desc = "Update",
            group = "Include",
            action = "Lazy update",
            key = "u",
          },
          {
            icon = " ",
            desc = "Files",
            group = "Function",
            action = "Telescope find_files",
            key = "f",
          },
          {
            icon = " ",
            desc = "Grep",
            group = "String",
            action = "Telescope live_grep",
            key = "g",
          },
          {
            icon = " ",
            desc = "Recent",
            group = "Statement",
            action = "Telescope oldfiles",
            key = "r",
          },
          {
            icon = " ",
            desc = "Config",
            group = "Special",
            action = "edit ~/.config/nvim/init.lua",
            key = "c",
          },
          {
            icon = "󰒲 ",
            desc = "Lazy",
            group = "Number",
            action = "Lazy",
            key = "l",
          },
          {
            icon = " ",
            desc = "Quit",
            group = "Error",
            action = "qa",
            key = "q",
          },
        },
        project = {
          enable = true,
          limit = 8,
          icon = "󰉋 ",
          label = "Recent Projects",
          action = "Telescope find_files cwd=",
        },
        mru = {
          limit = 8,
          icon = " ",
          label = "Recent Files",
        },
        footer = function()
          local stats = require("lazy").stats()
          return {
            "",
            "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded",
          }
        end,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Icons (mini.icons)
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- File type icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },

  -- Key binding hints (Helix-style layout)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "mordern",
      delay = 400,
      spec = {
        -- Top-level
        { "<leader>e", desc = "Toggle Neo-tree", icon = "" },
        { "<leader>E", desc = "Yazi (current file)", icon = "" },
        { "<leader>o", group = "outline" },
        { "<leader>s", desc = "Search & replace word" },
        { "<leader>/", desc = "Live grep" },
        { "<leader><leader>", desc = "Find files" },

        -- Buffers
        { "<leader>b", group = "buffer" },

        -- Git
        { "<leader>g", group = "git" },
        { "<leader>gt", group = "git toggle" },

        -- Windows
        { "<leader>w", group = "window" },

        -- Refactor
        { "<leader>r", group = "refactor", mode = { "n", "x" } },
        { "<leader>rb", group = "refactor block" },

        -- Diagnostics / Trouble
        { "<leader>x", group = "diagnostics" },

        -- Code / LSP
        { "<leader>c", group = "code" },
        { "<leader>cp", group = "package info" },
        { "<leader>cs", desc = "Symbols (Trouble)" },
        { "<leader>cl", desc = "LSP (Trouble)" },

        -- Notifications
        { "<leader>n", group = "notifications" },

        -- Jump
        { "<leader>j", group = "jump", icon = "󰕹" },

        -- Lazy
        { "<leader>l", group = "lazy", icon = "󰒲" },

        -- Marks
        { "<leader>m", group = "marks", icon = "󰓾" },

        -- Persistence / sessions
        { "<leader>p", group = "persistence", icon = "" },

        -- Debug (DAP)
        { "<leader>d", group = "debug", icon = "" },

        -- Test
        { "<leader>t", group = "test", icon = "󰙨" },

        -- Quit / save
        { "<leader>q", group = "quit/save" },
      },
    },
  },

  -- Enhanced UI for messages, cmdline, popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = require "configs.noice",
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      timeout = 500,
      render = "compact",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.25)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },

  -- LSP progress indicator
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
          border = "rounded",
        },
      },
    },
  },

  -- Floating filename in top-right
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup {
        highlight = {
          groups = {
            InclineNormal = { guibg = "#303270", guifg = "#a9b1d6" },
            InclineNormalNC = { guibg = "none", guifg = "#a9b1d6" },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = { cursorline = true, only_win = true },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[*]" .. filename
          end
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      }
    end,
  },

  -- Buffer tabs (tab mode)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- Enhanced vim.ui.select / vim.ui.input
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Rainbow bracket highlighting
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- 80-char column marker
  {
    "lukas-reineke/virt-column.nvim",
    event = "BufReadPost",
    opts = {
      char = { "┆" },
      virtcolumn = "80",
      highlight = { "NonText" },
    },
  },

  -- Breadcrumb navigation
  {
    "SmiteshP/nvim-navic",
    lazy = true,
  },
  {
    "LunarVim/breadcrumbs.nvim",
    event = "LspAttach",
    dependencies = { "SmiteshP/nvim-navic" },
    config = function()
      require("breadcrumbs").setup()
    end,
  },
}
