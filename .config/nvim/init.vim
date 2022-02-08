""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                              "
" Install Dependencies (Arch):                                                 "
"                                                                              "
" $ pacman -S neovim                                                           "
" $ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \       "
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim    "
"                                                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Plugins
call plug#begin( '~/.local/share/nvim/plugged' )

"
" Most Vim colorschemse are designed to be run in a GUI (e.g. GVim); however, they often are not
" displayed correctly in the terminal. The CSExact plugin helps to fix this by modifying the
" terminal's color pallete.
"
" If a supported terminal is being used, then uncomment the below line to properly display Vim
" colorschemes.
"
" NOTE: This plugin is NOT necessary for terminals with 24-bit (truecolor) support.
"
"Plug 'kevingoodsell/vim-csexact'

Plug 'flazz/vim-colorschemes'
Plug 'dbb/vim-gummybears-colorscheme'
Plug 'arcticicestudio/nord-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'qpkorr/vim-bufkill'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-gitgutter'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/a.vim'
Plug 'junegunn/goyo.vim'

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'deoplete-plugins/deoplete-clang'
"Plug 'deoplete-plugins/deoplete-jedi'

" The 'justinmk/vim-syntax-extra plugin has syntax highlighting for
" Flex/Bison, whereas the 'dccmx/vim-lemon-syntax has syntax highlighting for
" Lemon. Uncomment whichever one you want to use.
Plug 'justinmk/vim-syntax-extra'

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Shougo/vinarise.vim'

call plug#end()


" CSExact Plugin

" Fix issue where CSExact thinks that 'term' is "nvim".
"let g:csexact_term_override = $TERM


" Colors

" Enable syntax processing.
syntax enable

" Syntax-highlighting for custom / unpopular extensions
autocmd BufNewFile,BufRead *.re set syntax=cpp

"
" Favorite colorschemes:
"
" * 256-grayvim
" * Tomorrow-Night
" * alduin
" * ayu
" * gruvbox
" * gummybears
" * happy_hacking
" * hybrid/hybrid_reverse
" * ir_black
" * jellybeans
" * magellan
" * materialbox/material-theme
" * maui
" * oxeded
" * phoenix
" * sourcerer
" * tender
" * unicon
" * void
" * vorange
" * wombat256
" * xoria256
" * znake
" * nord
"

colorscheme hybrid

" Some colorschemes look better without setting 'termguicolors'.
" NOTE: Terminal must have 24-bit (truecolor) support to enable this setting.
let s:term_colorschemes = '256-grayvim|Tomorrow-Night|ir_black|materialbox|unicon'
if get( g:, 'colors_name', 'default' ) !~# '\v^(' . s:term_colorschemes . ')$'
    set termguicolors
endif


" UI Layout

" Show line numbers to the left of each line.
set number
set relativenumber
set numberwidth=4

" Highlight the current line.
set cursorline

" Highlight a specific column as a visual hint, where to wrap lines.
set colorcolumn=100
highlight ColorColumn ctermbg=236 ctermfg=white guibg=#282a2e guifg=#ffffff


" Spaces / Tabs

" Enable filetype-specific plugins / indentation.
filetype plugin indent on

" Make indentations levels 4 spaces; tabs are NOT used.
" See here: https://tedlogan.com/techblog3.html
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Customize indentation for C/C++ files.
set cinoptions=l1,N-s,E-s,t0,c4,C1,(s,u0,U1,W4,k2s,g0,:0

" Custom indentation for certain file types.
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab


" Leader Mappings

" Set a more sensible 'mapleader'.
let mapleader=','

" Turn off highlighting of previous search.
nnoremap <Leader>/ :nohlsearch<CR>

" Toggle zoom on a particular window (e.g. like in `tmux` with CTRL-B + z).
"nnoremap <Leader>z :call zoom#toggle()<CR>

" Quickly toggle the NERDTree.
nnoremap <Leader>n :NERDTreeToggle<CR>

" Quickly toggle Gundo.
nnoremap <Leader>g :GundoToggle<CR>


" Searching / Substitution

" Search as characters are entered.
set incsearch
" Highlight matches.
set hlsearch

" All lowercase-only search patterns are case-insensitive.
" NOTE: Case-(in)sensitivity can be enforced by including "\c" or "\C" in the search pattern.
set ignorecase
set smartcase

" Show a live preview of search/replace commands as characters are entered.
set inccommand=nosplit


" Folding

" TODO: Add settings to customize folding.


" Movement
nnoremap <Space> <PageDown>
nnoremap -       <PageUp>
vnoremap <Space> <PageDown>
vnoremap -       <PageUp>

" Speed up scrolling of the viewport.
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
vnoremap <C-e> 2<C-e>
vnoremap <C-y> 2<C-y>

" Keep 4 lines off the edges of the screen when scrolling.
set scrolloff=4

" Use g + h/j/k/l to navigate between windows.
nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l

" Place new horizontal-split window to the right.
set splitright
" Place new vertical-split window below.
set splitbelow


" Miscellaneous

" Hide buffers, rather than closing them.
set hidden

" Do NOT wrap long lines by default.
set nowrap

" Quickly enter commands.
nnoremap ; :
vnoremap ; :

" Save files opened without write permissions.
cnoremap w!! w !sudo tee %

" Enter visual-mode, selecting the text that was last inserted.
"nnoremap gV `[v`]

" Enable incrementing of characters and octal numbers using CTRL-A and g + CTRL-A.
set nrformats+=alpha
set nrformats+=octal

" Undo history is persistent.
set undofile


" Vim-airline Plugin
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

let g:airline_powerline_fonts = 1
if !exists( 'g:airline_symbols' )
    let g:airline_symbols = {}
endif

"
" The below is a workaround for some symbols not being supported by certain fonts.
" Replace the symbols below with those that are supported by the current terminal font.
"
let g:airline_left_sep           = ''
let g:airline_left_alt_sep       = ''
let g:airline_right_sep          = ''
let g:airline_right_alt_sep      = ''
let g:airline_symbols.branch     = ''
let g:airline_symbols.readonly   = ''
let g:airline_symbols.linenr     = 'Ξ'
let g:airline_symbols.maxlinenr  = ''
let g:airline_symbols.dirty      = '⚡'

let g:airline_theme = 'murmur'


" Bufkill Plugin

" Replace buffer commands with the enhanced "bufkill" versions.
cabbrev bun <C-r>=( getcmdtype() == ':' && getcmdpos() == 1 ? 'BUN' : 'bun' )<CR>
cabbrev bw  <C-r>=( getcmdtype() == ':' && getcmdpos() == 1 ? 'BW'  : 'bw'  )<CR>
cabbrev bd  <C-r>=( getcmdtype() == ':' && getcmdpos() == 1 ? 'BD'  : 'bd'  )<CR>


" NERDTree Plugin
augroup nerdtreegroup
    autocmd!
    autocmd StdinReadPre * let s:std_in=1

    " Open NERDTree automatically when Vim starts up.
    "autocmd VimEnter * NERDTreeFocus | wincmd p
    " Open NERDTree automatically even if no files were specified.
    autocmd VimEnter *
                \   if argc() == 0 && !exists( 's:std_in' )
                \       | NERDTreeFocus |
                \   endif
    " Open NERDTree automatically when Vim starts up, upon opening a directory.
    autocmd VimEnter *
                \   if argc() == 1 && isdirectory( argv()[0] ) && !exists( 's:std_in' )
                \       | exe 'cd ' . argv()[0] | set bufhidden=wipe | ene | NERDTreeFocus |
                \   endif

    " Close Vim if the only window left open is NERDTree.
    autocmd BufEnter *
                \   if winnr( '$' ) == 1 && exists( 'b:NERDTree' ) && b:NERDTree.isTabTree()
                \       | q |
                \   endif
augroup END


" NERDCommenter Plugin
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1


" HighlightedYank Plugin
let g:highlightedyank_highlight_duration=1000
"highlight HighlightedyankRegion ctermbg=236 guibg=#282a2e ctermfg=white guifg=#ffffff


" GitGutter Plugin

" Update signs more frequently.
set updatetime=100

" Do NOT allow GitGutter to clobber other signs.
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_max_signs = 1000

" Fix issue where the sign column symbols are not displaying properly.
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" These mappings are somehow NOT getting defined by GitGutter.
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)

" Change the below mappings to be "?h" (as in "hunk") rather than the default "?c".
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

omap ih <Plug>(GitGutterTextObjectInnerPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)


" Gundo Plugin

" Tell Gundo to use Python 3.
let g:gundo_prefer_python3 = 1


" Multiple Cursors Plugin

" Press <Esc> only once to exit multiple cursors.
let g:multi_cursor_exit_from_visual_mode = 1
let g:multi_cursor_exit_from_insert_mode = 1

highlight multiple_cursors_cursor ctermbg=236 guibg=#373b41
highlight link multiple_cursors_visual Visual


" Goyo Plugin

let g:goyo_width = 100

" Custom Goyo actions on enter
function! s:goyo_enter()
    " Disable Tmux status bar while in Goyo.
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status off
        silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    " Disable some potentially-distracting configuration options.
    set noshowmode
    set noshowcmd
    set scrolloff=999
endfunction

" Custom Goyo actions on leave
function! s:goyo_leave()
    " Re-enable Tmux status bar when exiting Goyo.
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    " Re-enable previous configuration.
    set showmode
    set showcmd
    set scrolloff=4
endfunction

augroup goyogroup
    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END

" Quickly toggle Goyo
nnoremap <Leader>z :Goyo<CR>


" Deoplete plugin
"let g:deoplete#enable_at_startup = 1

" Setting recommended here: https://jdhao.github.io/2019/06/06/nvim_deoplete_settings/
"call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})

" Maximum candidate window length
"call deoplete#custom#source('_', 'max_menu_width', 80)


" Cpp-enhanced-highlight plugin

" Highlighting of class scope is disabled by default. To enable set
let g:cpp_class_scope_highlight = 1
" Highlighting of member variables is disabled by default. To enable set
let g:cpp_member_variable_highlight = 1
" Highlighting of class names in declarations is disabled by default. To enable set
"let g:cpp_class_decl_highlight = 1
" Highlighting of POSIX functions is disabled by default. To enable set
"let g:cpp_posix_standard = 1

" There are two ways to highlight template functions. Either
let g:cpp_experimental_simple_template_highlight = 1
" which works in most cases, but can be a little slow on large files. Alternatively set
"let g:cpp_experimental_template_highlight = 1
" which is a faster implementation but has some corner cases where it doesn't work.

" Highlighting of library concepts is enabled by
"let g:cpp_concepts_highlight = 1

" Highlighting of user defined functions can be disabled by
"let g:cpp_no_function_highlight = 1


" Clang-format
map <C-F> :pyf ~/.local/share/clang-format/clang-format.py<CR>
imap <C-F> <c-o>:pyf ~/.local/share/clang-format/clang-format.py<CR>
