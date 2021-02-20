
filetype plugin on

" Line numbers
set number

" Default tab = 4 spaces
set tabstop=4

" '>' and '<' shift spacing
set shiftwidth=4

"set smartindent
set autoindent
set noexpandtab

syntax on

"" Search options

" Highlight matched searches
set hlsearch
" Update highlighting with every character typed
set incsearch

" Make all searching use extended regular expressions (map all searches to add \v)
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %s/\v


" Blink instead of beep on invalid operation
set visualbell

colorscheme onedark



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command -range Listify <line1>,<line2>s/^\(\w\)/* \1/ | nohl

" Copy all matches into specified register
function! CopyMatches(reg)
    let hits = []
    %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
    let reg = empty(a:reg) ? '+' : a:reg
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

" Copy all href links from the buffer into a register. These can be both relative
" or absolute links
function! CopyHrefLinks(reg)
	" highlight all href="..." matches
	/href=".\{-}"/

	" copy mayches into our selected registers
	call CopyMatches(a:reg)

	" remove "href=" and quotes from selected text
	execute 'let @'.a:reg.' = substitute(getreg(a:reg),"\\(href=\\)\\|\\(\"\\)","","g")'
endfunction
command! -register CopyHrefLinks call CopyHrefLinks(<q-reg>)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

"Plug 'vim-syntastic/syntastic'
" Nginx syntax highlighting
Plug 'chr4/nginx.vim'

" NERD Tree directory viewer
Plug 'scrooloose/nerdtree', {'on':'NERDTreeToggle'}

"" Language support

Plug 'ycm-core/YouCompleteMe'

"" Tex
Plug 'lervag/vimtex'



" CSV
Plug 'chrisbra/csv.vim'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
"autocmd Filetype python setlocal tabstop=4

let g:ycm_filetype_blacklist = { 'sql': 1, 'markdown': 1 }

let g:tex_flavor = 'latex'

" Assembly
let g:asmsyntax = 'nasm'
autocmd Filetype nasm setlocal tabstop=8
