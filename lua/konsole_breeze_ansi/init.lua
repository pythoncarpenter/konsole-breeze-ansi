local M = {}

function M.setup(opts)
  opts = opts or {}

  vim.opt.termguicolors = true

  -- Prefer LSP semantic token classification over Treesitter when both exist.
  local priorities = nil
  if vim.highlight and vim.highlight.priorities then
    priorities = vim.highlight.priorities
  elseif vim.hl and vim.hl.priorities then
    priorities = vim.hl.priorities
  end
  if priorities then
    priorities.semantic_tokens = 130
    priorities.treesitter = 120
    priorities.syntax = 100
  end

  if opts.semantic ~= false then
    vim.g.loaded_konsole_breeze_ansi_semantic = true

    local group = vim.api.nvim_create_augroup("KonsoleBreezeAnsiSemantic", { clear = true })
    vim.api.nvim_create_autocmd({ "ColorScheme", "LspAttach" }, {
      group = group,
      callback = function(ev)
        if ev.event == "ColorScheme" and vim.g.colors_name ~= "konsole_breeze_ansi" then
          return
        end
        require("konsole_breeze_ansi.semantic").apply()
        require("konsole_breeze_ansi.contextual").refresh(ev.buf)
      end,
    })

    require("konsole_breeze_ansi.contextual").setup()
  end

  if opts.transparent then
    vim.g.konsole_breeze_ansi_transparent = true
  end

  vim.cmd.colorscheme("konsole_breeze_ansi")

  if opts.semantic ~= false then
    require("konsole_breeze_ansi.contextual").refresh()
  end

  if opts.transparent then
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = "#fcfcfc" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", fg = "#fcfcfc" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", fg = "#7f8c8d" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", fg = "#232627" })
  end
end

return M
