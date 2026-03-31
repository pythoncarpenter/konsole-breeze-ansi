hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "konsole_breeze_ansi"
set termguicolors

" Breeze-inspired semantic palette
let g:terminal_color_0  = "#232627"
let g:terminal_color_1  = "#eba0ac"
let g:terminal_color_2  = "#a6e3a1"
let g:terminal_color_3  = "#fab387"
let g:terminal_color_4  = "#3daee9"
let g:terminal_color_5  = "#cba6f7"
let g:terminal_color_6  = "#1abc9c"
let g:terminal_color_7  = "#cdd6f4"
let g:terminal_color_8  = "#7f8c8d"
let g:terminal_color_9  = "#eba0ac"
let g:terminal_color_10 = "#a6e3a1"
let g:terminal_color_11 = "#fab387"
let g:terminal_color_12 = "#89b4fa"
let g:terminal_color_13 = "#cba6f7"
let g:terminal_color_14 = "#16a085"
let g:terminal_color_15 = "#cdd6f4"

hi Normal       guibg=#232627 guifg=#cdd6f4 gui=NONE cterm=NONE
hi NormalNC     guibg=#232627 guifg=#cdd6f4 gui=NONE cterm=NONE
hi SignColumn   guibg=#232627 guifg=#7f8c8d gui=NONE cterm=NONE
hi EndOfBuffer  guibg=#232627 guifg=#232627 gui=NONE cterm=NONE
hi NonText      guibg=#232627 guifg=#63686d gui=NONE cterm=NONE
hi Whitespace   guibg=#232627 guifg=#63686d gui=NONE cterm=NONE

hi LineNr       guibg=#232627 guifg=#7f8c8d gui=NONE cterm=NONE
hi CursorLineNr guibg=#232627 guifg=#cdd6f4 gui=bold cterm=bold
hi CursorLine   guibg=#2a2e2f guifg=NONE gui=NONE cterm=NONE
hi CursorColumn guibg=#2a2e2f guifg=NONE gui=NONE cterm=NONE
hi ColorColumn  guibg=#2a2e2f guifg=NONE gui=NONE cterm=NONE

hi Visual       guibg=#1b668f guifg=#cdd6f4 gui=NONE cterm=NONE
hi Search       guibg=#186c60 guifg=#cdd6f4 gui=NONE cterm=NONE
hi IncSearch    guibg=#fab387 guifg=#232627 gui=bold cterm=bold
hi MatchParen   guibg=#cba6f7 guifg=#232627 gui=bold cterm=bold

hi StatusLine   guibg=#31363b guifg=#cdd6f4 gui=NONE cterm=NONE
hi StatusLineNC guibg=#31363b guifg=#7f8c8d gui=NONE cterm=NONE
hi VertSplit    guibg=#31363b guifg=#31363b gui=NONE cterm=NONE

hi Pmenu        guibg=#31363b guifg=#cdd6f4 gui=NONE cterm=NONE
hi PmenuSel     guibg=#3daee9 guifg=#232627 gui=NONE cterm=NONE
hi PmenuSbar    guibg=#545d5e guifg=NONE gui=NONE cterm=NONE
hi PmenuThumb   guibg=#7f8c8d guifg=#7f8c8d gui=NONE cterm=NONE

hi ErrorMsg     guibg=NONE guifg=#eba0ac gui=bold cterm=bold
hi WarningMsg   guibg=NONE guifg=#eba0ac gui=bold cterm=bold
hi DiagnosticError guibg=NONE guifg=#eba0ac gui=NONE cterm=NONE
hi DiagnosticWarn  guibg=NONE guifg=#eba0ac gui=NONE cterm=NONE
hi DiagnosticInfo  guibg=NONE guifg=#89b4fa gui=NONE cterm=NONE
hi DiagnosticHint  guibg=NONE guifg=#1abc9c gui=NONE cterm=NONE

hi DiagnosticVirtualTextError guibg=#2a2e2f guifg=#eba0ac gui=italic cterm=italic
hi DiagnosticVirtualTextWarn  guibg=#2a2e2f guifg=#eba0ac gui=italic cterm=italic
hi DiagnosticVirtualTextInfo  guibg=#2a2e2f guifg=#89b4fa gui=italic cterm=italic
hi DiagnosticVirtualTextHint  guibg=#2a2e2f guifg=#16a085 gui=italic cterm=italic

hi Comment      guibg=NONE guifg=#9399b2 gui=italic cterm=italic
hi Constant     guibg=NONE guifg=#cba6f7 gui=NONE cterm=NONE
hi String       guibg=NONE guifg=#A6E3A1 gui=NONE cterm=NONE
hi Character    guibg=NONE guifg=#A6E3A1 gui=NONE cterm=NONE
hi Number       guibg=NONE guifg=#fab387 gui=NONE cterm=NONE
hi Boolean      guibg=NONE guifg=#fab387 gui=NONE cterm=NONE
hi Float        guibg=NONE guifg=#fab387 gui=NONE cterm=NONE

hi Identifier   guibg=NONE guifg=#cdd6f4 gui=NONE cterm=NONE
hi Function     guibg=NONE guifg=#cba6f7 gui=NONE cterm=NONE

hi Statement    guibg=NONE guifg=#3daee9 gui=bold cterm=bold
hi Conditional  guibg=NONE guifg=#3daee9 gui=bold cterm=bold
hi Repeat       guibg=NONE guifg=#3daee9 gui=bold cterm=bold
hi Keyword      guibg=NONE guifg=#3daee9 gui=bold cterm=bold
hi Operator     guibg=NONE guifg=#cdd6f4 gui=NONE cterm=NONE

hi PreProc      guibg=NONE guifg=#1abc9c gui=NONE cterm=NONE
hi Include      guibg=NONE guifg=#1abc9c gui=NONE cterm=NONE
hi Define       guibg=NONE guifg=#1abc9c gui=NONE cterm=NONE
hi Macro        guibg=NONE guifg=#1abc9c gui=NONE cterm=NONE

hi Type         guibg=NONE guifg=#cba6f7 gui=NONE cterm=NONE
hi StorageClass guibg=NONE guifg=#cba6f7 gui=NONE cterm=NONE
hi Structure    guibg=NONE guifg=#cba6f7 gui=NONE cterm=NONE
hi Typedef      guibg=NONE guifg=#cba6f7 gui=NONE cterm=NONE

hi Special      guibg=NONE guifg=#1abc9c gui=NONE cterm=NONE
hi Delimiter    guibg=NONE guifg=#cdd6f4 gui=NONE cterm=NONE
hi Underlined   guibg=NONE guifg=#89b4fa gui=underline cterm=underline
hi Todo         guibg=#31363b guifg=#fab387 gui=bold cterm=bold

hi DiffAdd      guibg=#123723 guifg=NONE gui=NONE cterm=NONE
hi DiffChange   guibg=#424218 guifg=NONE gui=NONE cterm=NONE
hi DiffDelete   guibg=#4d1f24 guifg=#eba0ac gui=NONE cterm=NONE
hi DiffText     guibg=#1b668f guifg=#cdd6f4 gui=bold cterm=bold

if exists("g:loaded_konsole_breeze_ansi_semantic")
  lua require("konsole_breeze_ansi.semantic").apply()
endif
