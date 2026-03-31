local M = {}

local function set(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

function M.apply()
  -- Treesitter
  set("@comment", { fg = "#7f8c8d", italic = true })
  set("@string", { fg = "#A6E3A1" })
  set("@string.regex", { fg = "#1abc9c" })
  set("@number", { fg = "#8e44ad" })
  set("@boolean", { fg = "#8e44ad" })
  set("@constant", { fg = "#9b59b6" })
  set("@constant.builtin", { fg = "#8e44ad" })
  set("@type", { fg = "#9b59b6" })
  set("@type.builtin", { fg = "#8e44ad" })
  set("@constructor", { fg = "#3daee9" })
  set("@function", { fg = "#1d99f3" })
  set("@function.builtin", { fg = "#3daee9" })
  set("@function.method", { fg = "#1d99f3" })
  set("@keyword", { fg = "#1d99f3", bold = true })
  set("@keyword.return", { fg = "#1d99f3", bold = true })
  set("@keyword.operator", { fg = "#1d99f3", bold = true })
  set("@operator", { fg = "#fcfcfc" })
  set("@property", { fg = "#fcfcfc" })
  set("@variable", { fg = "#fcfcfc" })
  set("@variable.builtin", { fg = "#3daee9" })
  set("@punctuation.delimiter", { fg = "#fcfcfc" })
  set("@punctuation.bracket", { fg = "#fcfcfc" })

  -- LSP semantic tokens
  set("@lsp.type.type", { fg = "#9b59b6" })
  set("@lsp.type.class", { fg = "#9b59b6" })
  set("@lsp.type.enum", { fg = "#9b59b6" })
  set("@lsp.type.interface", { fg = "#9b59b6" })
  set("@lsp.type.struct", { fg = "#9b59b6" })
  set("@lsp.type.namespace", { fg = "#3daee9" })
  set("@lsp.type.parameter", { fg = "#fcfcfc" })
  set("@lsp.type.property", { fg = "#fcfcfc" })
  set("@lsp.type.variable", { fg = "#fcfcfc" })
  set("@lsp.type.function", { fg = "#1d99f3" })
  set("@lsp.type.method", { fg = "#1d99f3" })
  set("@lsp.type.keyword", { fg = "#1d99f3", bold = true })
  set("@lsp.type.enumMember", { fg = "#8e44ad" })
  set("@lsp.type.decorator", { fg = "#f67400" })

  set("@lsp.mod.readonly", { italic = true })
  set("@lsp.mod.defaultLibrary", { fg = "#3daee9" })
  set("@lsp.mod.deprecated", { strikethrough = true })
end

return M
