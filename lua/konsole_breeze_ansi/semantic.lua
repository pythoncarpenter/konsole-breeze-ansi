local M = {}

local function set(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

function M.apply()
  -- Treesitter
  set("@comment", { fg = "#7f8c8d", italic = true })
  set("@string", { fg = "#A6E3A1" })
  set("@string.regex", { fg = "#1abc9c" })
  set("@number", { fg = "#FAB387" })
  set("@boolean", { fg = "#FAB387" })
  set("@constant", { fg = "#CBA6F7" })
  set("@constant.builtin", { fg = "#CBA6F7" })
  set("@type", { fg = "#CBA6F7" })
  set("@type.builtin", { fg = "#CBA6F7" })
  set("@constructor", { fg = "#89B4FA" })
  set("@function", { fg = "#CBA6F7" })
  set("@function.builtin", { fg = "#89B4FA" })
  set("@function.method", { fg = "#CBA6F7" })
  set("@keyword", { fg = "#3DAEE9", bold = true })
  set("@keyword.return", { fg = "#3DAEE9", bold = true })
  set("@keyword.operator", { fg = "#3DAEE9", bold = true })
  set("@operator", { fg = "#CDD6F4" })
  set("@property", { fg = "#CDD6F4" })
  set("@variable", { fg = "#CDD6F4" })
  set("@variable.builtin", { fg = "#89B4FA" })
  set("@punctuation.delimiter", { fg = "#CDD6F4" })
  set("@punctuation.bracket", { fg = "#CDD6F4" })

  -- LSP semantic tokens
  set("@lsp.type.type", { fg = "#CBA6F7" })
  set("@lsp.type.class", { fg = "#CBA6F7" })
  set("@lsp.type.enum", { fg = "#CBA6F7" })
  set("@lsp.type.interface", { fg = "#CBA6F7" })
  set("@lsp.type.struct", { fg = "#CBA6F7" })
  set("@lsp.type.namespace", { fg = "#1ABC9C" })
  set("@lsp.type.parameter", { fg = "#CDD6F4" })
  set("@lsp.type.property", { fg = "#CDD6F4" })
  set("@lsp.type.variable", { fg = "#CDD6F4" })
  set("@lsp.type.function", { fg = "#CBA6F7" })
  set("@lsp.type.method", { fg = "#CBA6F7" })
  set("@lsp.type.keyword", { fg = "#3DAEE9", bold = true })
  set("@lsp.type.enumMember", { fg = "#FAB387" })
  set("@lsp.type.decorator", { fg = "#89B4FA" })

  set("@lsp.mod.readonly", { italic = true })
  set("@lsp.mod.defaultLibrary", { fg = "#89B4FA" })
  set("@lsp.mod.deprecated", { strikethrough = true })
end

return M
