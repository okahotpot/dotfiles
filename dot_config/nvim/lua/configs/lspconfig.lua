require("nvchad.configs.lspconfig").defaults()

-- Simple servers (no custom config needed)
vim.lsp.enable { "html", "cssls", "clangd", "pyright" }

-- gopls (Go) — disable all inlay hints
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = { unusedparams = true },
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = false,
        functionTypeParameters = false,
        parameterNames = false,
        rangeVariableTypes = false,
      },
    },
  },
})

-- vtsls (TypeScript/JavaScript) — disable all inlay hints
vim.lsp.config("vtsls", {
  settings = {
    typescript = {
      inlayHints = {
        enumMemberValues = { enabled = false },
        functionLikeReturnTypes = { enabled = false },
        parameterNames = { enabled = false },
        parameterTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = false },
        variableTypes = { enabled = false },
      },
    },
    javascript = {
      inlayHints = {
        enumMemberValues = { enabled = false },
        functionLikeReturnTypes = { enabled = false },
        parameterNames = { enabled = false },
        parameterTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = false },
        variableTypes = { enabled = false },
      },
    },
  },
})

vim.lsp.enable { "gopls", "vtsls" }

-- Suppress "No information available" on hover
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
  config = config or {
    border = {
      { "╭", "Comment" }, { "─", "Comment" }, { "╮", "Comment" },
      { "│", "Comment" }, { "╯", "Comment" }, { "─", "Comment" },
      { "╰", "Comment" }, { "│", "Comment" },
    },
  }
  config.focus_id = ctx.method
  if not (result and result.contents) then return end
  local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
  if vim.tbl_isempty(markdown_lines) then return end
  return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
end
