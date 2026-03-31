# konsole-breeze-ansi

Strict Konsole Breeze ANSI-fidelity colorscheme for Neovim.

## Goals

- Match Konsole's built-in Breeze ANSI palette exactly
- Use the Konsole Breeze background and foreground, not pure black
- Cover:
  - classic Vim highlight groups
  - Treesitter captures
  - LSP semantic tokens

## Palette

- Background: `#232627`
- Foreground: `#fcfcfc`

ANSI 0-15:

- `#232627`
- `#ed1515`
- `#11d116`
- `#f67400`
- `#1d99f3`
- `#9b59b6`
- `#1abc9c`
- `#fcfcfc`
- `#7f8c8d`
- `#c0392b`
- `#1cdc9a`
- `#fdbc4b`
- `#3daee9`
- `#8e44ad`
- `#16a085`
- `#ffffff`

## lazy.nvim

```lua
{
  "pythoncarpenter/konsole-breeze-ansi",
  lazy = false,
  priority = 1000,
  config = function()
    require("konsole_breeze_ansi").setup({
      semantic = true,
      transparent = false,
    })
  end,
}
