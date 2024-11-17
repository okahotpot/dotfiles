return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    opts = function()
      local cmp = require("cmp")
      return {
        mapping = cmp.mapping.preset.insert({
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        -- completion = { autocomplete = true },
        -- mapping = { ["<CR>"] = nil },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
        },
        window = {
          completion = {
            border = {
              { "󱐋", "WarningMsg" },
              { "─", "Comment" },
              { "╮", "Comment" },
              { "│", "Comment" },
              { "╯", "Comment" },
              { "─", "Comment" },
              { "╰", "Comment" },
              { "│", "Comment" },
            },
            scrollbar = false,
            winblend = 0,
          },
          documentation = {
            border = {
              { "󰙎", "DiagnosticHint" },
              { "─", "Comment" },
              { "╮", "Comment" },
              { "│", "Comment" },
              { "╯", "Comment" },
              { "─", "Comment" },
              { "╰", "Comment" },
              { "│", "Comment" },
            },
            scrollbar = false,
            winblend = 0,
          },
        },
      }
    end,
  },
}
