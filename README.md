# konsole-breeze-ansi

Breeze-inspired semantic colorscheme for Neovim with a dark Breeze-like background.

## Screenshot

![Python variable coloring preview](assets/screenshots/python-variable-coloring.png)

## Semantic Palette

- `action_label` `#3DAEE9` (breeze blue)
- `info_blue` `#89B4FA` (light blue)
- `command_name` `#CBA6F7` (lavender)
- `path` `#1ABC9C` (breeze teal)
- `string` `#A6E3A1` (mint frost)
- `number` `#FAB387` (soft orange)
- `text` `#CDD6F4` (dirty white)
- `warning` `#EBA0AC` (pinky brick red)

## Palette

- Background: `#232627`
- Foreground: `#cdd6f4`

ANSI 0-15:

- `#232627`
- `#eba0ac`
- `#a6e3a1`
- `#fab387`
- `#3daee9`
- `#cba6f7`
- `#1abc9c`
- `#cdd6f4`
- `#7f8c8d`
- `#eba0ac`
- `#a6e3a1`
- `#fab387`
- `#89b4fa`
- `#cba6f7`
- `#16a085`
- `#cdd6f4`

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
