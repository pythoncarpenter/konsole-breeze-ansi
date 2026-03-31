local M = {}

function M.setup(opts)
  opts = opts or {}

  vim.opt.termguicolors = true

  if opts.semantic ~= false then
    vim.g.loaded_konsole_breeze_ansi_semantic = true
  end

  if opts.transparent then
    vim.g.konsole_breeze_ansi_transparent = true
  end

  vim.cmd.colorscheme("konsole_breeze_ansi")

  if opts.transparent then
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = "#fcfcfc" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", fg = "#fcfcfc" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", fg = "#7f8c8d" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", fg = "#232627" })
  end
end

return M
