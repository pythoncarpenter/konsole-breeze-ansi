hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "konsole_breeze_ansi"
set termguicolors

" Strict Konsole Breeze ANSI palette
let g:terminal_color_0  = "#232627"
let g:terminal_color_1  = "#ed1515"
let g:terminal_color_2  = "#11d116"
let g:terminal_color_3  = "#f67400"
let g:terminal_color_4  = "#1d99f3"
let g:terminal_color_5  = "#9b59b6"
let g:terminal_color_6  = "#1abc9c"
let g:terminal_color_7  = "#fcfcfc"
let g:terminal_color_8  = "#7f8c8d"
let g:terminal_color_9  = "#c0392b"
let g:terminal_color_10 = "#1cdc9a"
let g:terminal_color_11 = "#fdbc4b"
let g:terminal_color_12 = "#3daee9"
let g:terminal_color_13 = "#8e44ad"
let g:terminal_color_14 = "#16a085"
let g:terminal_color_15 = "#ffffff"

hi Normal       guibg=#232627 guifg=#fcfcfc gui=NONE cterm=NONE
hi NormalNC     guibg=#232627 guifg=#fcfcfc gui=NONE cterm=NONE
hi SignColumn   guibg=#232627 guifg=#7f8c8d gui=NONE cterm=NONE
hi EndOfBuffer  guibg=#232627 guifg=#232627 gui=NONE cterm=NONE
hi NonText      guibg=#232627 guifg=#63686d gui=NONE cterm=NONE
hi Whitespace   guibg=#232627 guifg=#63686d gui=NONE cterm=NONE

hi LineNr       guibg=#232627 guifg=#7f8c8d gui=NONE cterm=NONE
hi CursorLineNr guibg=#232627 guifg=#fcfcfc gui=bold cterm=bold
hi CursorLine   guibg=#2a2e2f guifg=NONE gui=NONE cterm=NONE
hi CursorColumn guibg=#2a2e2f guifg=NONE gui=NONE cterm=NONE
hi ColorColumn  guibg=#2a2e2f guifg=NONE gui=NONE cterm=NONE

hi Visual       guibg=#1b668f guifg=#fcfcfc gui=NONE cterm=NONE
hi Search       guibg=#186c60 guifg=#ffffff gui=NONE cterm=NONE
hi IncSearch    guibg=#fdbc4b guifg=#232627 gui=bold cterm=bold
hi MatchParen   guibg=#8e44ad guifg=#ffffff gui=bold cterm=bold

hi StatusLine   guibg=#31363b guifg=#fcfcfc gui=NONE cterm=NONE
hi StatusLineNC guibg=#31363b guifg=#7f8c8d gui=NONE cterm=NONE
hi VertSplit    guibg=#31363b guifg=#31363b gui=NONE cterm=NONE

hi Pmenu        guibg=#31363b guifg=#fcfcfc gui=NONE cterm=NONE
hi PmenuSel     guibg=#1d99f3 guifg=#ffffff gui=NONE cterm=NONE
hi PmenuSbar    guibg=#545d5e guifg=NONE gui=NONE cterm=NONE
hi PmenuThumb   guibg=#7f8c8d guifg=#7f8c8d gui=NONE cterm=NONE

hi ErrorMsg     guibg=NONE guifg=#ed1515 gui=bold cterm=bold
hi WarningMsg   guibg=NONE guifg=#f67400 gui=bold cterm=bold
hi DiagnosticError guibg=NONE guifg=#ed1515 gui=NONE cterm=NONE
hi DiagnosticWarn  guibg=NONE guifg=#f67400 gui=NONE cterm=NONE
hi DiagnosticInfo  guibg=NONE guifg=#1d99f3 gui=NONE cterm=NONE
hi DiagnosticHint  guibg=NONE guifg=#1abc9c gui=NONE cterm=NONE

hi DiagnosticVirtualTextError guibg=#2a2e2f guifg=#c0392b gui=italic cterm=italic
hi DiagnosticVirtualTextWarn  guibg=#2a2e2f guifg=#fdbc4b gui=italic cterm=italic
hi DiagnosticVirtualTextInfo  guibg=#2a2e2f guifg=#3daee9 gui=italic cterm=italic
hi DiagnosticVirtualTextHint  guibg=#2a2e2f guifg=#16a085 gui=italic cterm=italic

hi Comment      guibg=NONE guifg=#7f8c8d gui=italic cterm=italic
hi Constant     guibg=NONE guifg=#9b59b6 gui=NONE cterm=NONE
hi String       guibg=NONE guifg=#27ae60 gui=NONE cterm=NONE
hi Character    guibg=NONE guifg=#27ae60 gui=NONE cterm=NONE
hi Number       guibg=NONE guifg=#8e44ad gui=NONE cterm=NONE
hi Boolean      guibg=NONE guifg=#8e44ad gui=NONE cterm=NONE
hi Float        guibg=NONE guifg=#8e44ad gui=NONE cterm=NONE

hi Identifier   guibg=NONE guifg=#fcfcfc gui=NONE cterm=NONE
hi Function     guibg=NONE guifg=#1d99f3 gui=NONE cterm=NONE

hi Statement    guibg=NONE guifg=#1d99f3 gui=bold cterm=bold
hi Conditional  guibg=NONE guifg=#1d99f3 gui=bold cterm=bold
hi Repeat       guibg=NONE guifg=#1d99f3 gui=bold cterm=bold
hi Keyword      guibg=NONE guifg=#1d99f3 gui=bold cterm=bold
hi Operator     guibg=NONE guifg=#fcfcfc gui=NONE cterm=NONE

hi PreProc      guibg=NONE guifg=#f67400 gui=NONE cterm=NONE
hi Include      guibg=NONE guifg=#f67400 gui=NONE cterm=NONE
hi Define       guibg=NONE guifg=#f67400 gui=NONE cterm=NONE
hi Macro        guibg=NONE guifg=#f67400 gui=NONE cterm=NONE

hi Type         guibg=NONE guifg=#9b59b6 gui=NONE cterm=NONE
hi StorageClass guibg=NONE guifg=#9b59b6 gui=NONE cterm=NONE
hi Structure    guibg=NONE guifg=#9b59b6 gui=NONE cterm=NONE
hi Typedef      guibg=NONE guifg=#9b59b6 gui=NONE cterm=NONE

hi Special      guibg=NONE guifg=#1abc9c gui=NONE cterm=NONE
hi Delimiter    guibg=NONE guifg=#fcfcfc gui=NONE cterm=NONE
hi Underlined   guibg=NONE guifg=#3daee9 gui=underline cterm=underline
hi Todo         guibg=#31363b guifg=#fdbc4b gui=bold cterm=bold

hi DiffAdd      guibg=#123723 guifg=NONE gui=NONE cterm=NONE
hi DiffChange   guibg=#424218 guifg=NONE gui=NONE cterm=NONE
hi DiffDelete   guibg=#4d1f24 guifg=NONE gui=NONE cterm=NONE
hi DiffText     guibg=#1b668f guifg=#ffffff gui=bold cterm=bold

if exists("g:loaded_konsole_breeze_ansi_semantic")
  lua require("konsole_breeze_ansi.semantic").apply()
endif
