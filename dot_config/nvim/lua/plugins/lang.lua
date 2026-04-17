return {
  -- npm package version info (shown in package.json)
  {
    "vuki656/package-info.nvim",
    ft = "json",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("package-info").setup {
        autostart = false,
        package_manager = "npm",
        colors = { outdated = "#db4b4b" },
        hide_up_to_date = true,
      }
    end,
  },

  -- Linting (eslint_d, ktlint, tflint, standardrb)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        kotlin = { "ktlint" },
        terraform = { "tflint" },
        ruby = { "standardrb" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "CmdlineLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint(nil, { ignore_errors = true })
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint(nil, { ignore_errors = true })
      end, { desc = "Trigger linting for current file" })
    end,
  },

  -- null-ls: Go formatting (gofumpt, goimports_reviser, golines)
  {
    "nvimtools/none-ls.nvim",
    ft = "go",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require "null-ls"
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports_reviser,
          null_ls.builtins.formatting.golines,
        },
        on_attach = function(client, bufnr)
          if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end
        end,
      }
    end,
  },

  -- Code snapshots to clipboard / Desktop
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    cmd = { "CodeSnap", "CodeSnapSave" },
    keys = {
      { "<leader>cs", "<cmd>CodeSnap<cr>", mode = "x", desc = "Copy code snapshot to clipboard" },
      { "<leader>cd", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save code snapshot to ~/Desktop" },
    },
    opts = {
      save_path = "~/Desktop",
      has_breadcrumbs = true,
      bg_theme = "bamboo",
      code_font_family = "CaskaydiaCove Nerd Font",
      watermark_font_family = "Pacifico",
      watermark = "",
    },
  },

  -- Image preview in buffer
  {
    "adelarsq/image_preview.nvim",
    event = "VeryLazy",
    config = function()
      require("image_preview").setup()
    end,
  },
  -- Dim inactive code
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    opts = {
      context = 0,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
        "function_declaration",
        "method_declaration",
        "pair",
      },
    },
  },
}
