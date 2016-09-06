" Written with <3 by Sam Whiteley
" If you find yourself copying this verbatim, read
"  "Learn Vimscript the Hard Way - Steve Losh & Co."
" You won't regret it!
" PS: use spacebar to open those folds if this is now your .vimrc too.

execute pathogen#infect()

"{{{ Sane Defaults

"Important for good features
set nocompatible

"Line numbers on
set number numberwidth=4

"Don't wrap text lines
set nowrap

"Sane tab settings
set shiftround
set shiftwidth=2 tabstop=2
set expandtab smarttab

"Default fold method
set foldmethod=marker

"Don't let buffers hide in the background
set nohidden

"Filetypes and Syntax
filetype on
filetype plugin on
syntax enable

"Spellchecking defaults
set spl=en spell
set nospell

"Backspacing monkey-business
set backspace=2

"{{{ Search settings
set ignorecase
set smartcase
set incsearch
set hlsearch
"}}}

"{{{ I don't know what these do but better people than I use them...

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

"}}}

"}}}


"{{{ General Settings

"Guarantee status line exists and make it cool
set laststatus=2
set statusline=%.F%m%r\ b%n\ (%{&ff})%=%y[%3.16l,%3.4v][%3p%%]

"Prettifying stuff
set colorcolumn=80
set t_Co=256
"colorscheme torte
colorscheme monokai
set showcmd
" Bracket matching colours
highlight MatchParen ctermbg=4

"Use unix grep with -nH as default :grep
set grepprg=grep\ -nH\ $*

"Use auto-indenting!
set autoindent
set smartindent

"Format options
set formatoptions+=r "Adds new comment on enter when in insert
set formatoptions+=n "Smart list indenting (hopefully)
set formatoptions+=j "Make line joining delete comment leader if relevant

"Wildmenu allows for nicer autocomplete of commands
set wildmenu
set wildmode=list:longest,full

"}}}


"{{{ Key Mappings

"{{{ Leader and Presettings

"Good leader. Other options (-, _)
let mapleader=","
let maplocalleader="\\"

"}}}

"{{{ Experimental and Doohickeys

"relative number toggle
nnoremap <leader>rn :set relativenumber!<cr>

"quote word under cursor and a visual block
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>

"open last buffer in a pane after this
nnoremap <leader>el :execute "rightbelow split" bufname("#")<cr>

"grep for word under cursor
nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

"}}}

"{{{ Tabs & Windows

"create tabs easily
nnoremap <c-t> :Texplore<cr>
"switch tabs easy
nnoremap <c-h> :tabprevious<cr>
nnoremap <c-l> :tabnext<cr>

"Switch windows easy (no <c-w>)
nnoremap <leader>w <c-w>

"}}}

"{{{ Search

"Center search results vertically in window
noremap N Nzz
noremap n nzz

"Clear search highlighting
nnoremap <silent> <leader>/ :nohlsearch<cr>
"Clear search register
nnoremap <silent> <leader>d/ :let @/=""<cr>

"}}}

"{{{ Movement

"Always gj and gk (see help for difference)
nnoremap j gj
nnoremap k gk
nnoremap J 5j
nnoremap K 5k
nnoremap gJ J

"Easier line beginning and end
noremap H 0
noremap L $
"NOps are here until I unlearn hitting those
noremap 0 <nop>
noremap $ <nop>

"Up and down in insert for sensibility
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

"Parameters selector mapping
onoremap p i(
"Markdown "in heading" selector
onoremap ih :<c-u>execute "normal! ?^#.*$\r:nohlsearch\rwvg_"<cr>

"}}}

"Toggle folds
nnoremap <space> za

"Sane Input escape
inoremap jj <esc>

"Quick Edit and Source .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"move lines up and down (flips lines) --SHADES--
nnoremap - ddp
nnoremap _ ddkkp

"make blank lines from normal mode
nnoremap zj o<esc>
nnoremap zk O<esc>

"Delete line and start fresh
inoremap <c-d> <esc>ddO

"Uppercase current word
inoremap <c-u> <esc>viwU<esc>ea

"}}}


"{{{ Abbreviations

"Textual shortcuts and utilities
iabbrev @@ sam.whiteley@hotmail.com
iabbrev ccopy Copyright 2016 Sam Whiteley, all rights reserved.
iabbrev esig Cheers,<cr>Sam Whiteley
iabbrev ssite https://sqash.github.io

"Things I always mispell

"}}}


"{{{ Autocommands

"{{{ All Files
augroup file_general_treatment
" Remove trailing whitespace from lines when reading and writiing
  autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
augroup END
"}}}

"{{{ HTML_files
augroup HTML_files
  "THIS LOOKS REALLY BAD MOST OF THE TIME - retab HTML files on write
  "autocmd BufWritePre,BufRead *.html :normal gg=G
  "autocmd BufNewFile,BufRead *.html setlocal nowrap
augroup END
"}}}

"{{{ Markdown_files
augroup Markdown_files
" Set folds to start at ## headers
  function! MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h)
      if getline(v:lnum) =~? '\v^\s*$'
        return "-1"
      endif
      return "="
    else
      return ">" . (len(h) - 1)
    endif
  endfunction
  autocmd Filetype markdown setlocal foldexpr=MarkdownLevel()
  autocmd Filetype markdown setlocal foldmethod=expr
" Set spell checking
  autocmd Filetype markdown setlocal spell
  autocmd Filetype markdown setlocal formatoptions+=t
  autocmd Filetype markdown setlocal tw=79
" Set highlighting for misspelled words
  autocmd Filetype markdown highlight clear SpellBad
  autocmd Filetype markdown highlight SpellBad cterm=underline
augroup END
"}}}

"{{{ Tex_files
augroup Tex_files
  autocmd Filetype tex setlocal formatoptions+=t
  autocmd Filetype tex setlocal tw=79
  autocmd Filetype tex nnoremap <localleader>sp :set spell!<cr>
" Set highlighting for misspelled words
  autocmd Filetype tex highlight clear SpellBad
  autocmd Filetype tex highlight SpellBad cterm=underline
augroup END
"}}}

"{{{ Make_files
augroup Make_files
  autocmd Filetype make setlocal noexpandtab
augroup END
"}}}

"{{{ Processing_files
augroup Processing_files
  autocmd BufRead,BufNewFile  *.pde set filetype=processing
  autocmd FileType processing :set syntax=java
  autocmd FileType processing nnoremap <localleader>mr :!processing-java --sketch=%:p:h --run<cr>
augroup END
"}}}

"{{{ Lang_utilities
augroup Lang_utilities
  "Every coding language should have the same "Comment line" strokes
  autocmd Filetype javascript nnoremap <buffer> <localleader>c I//<esc>
  autocmd Filetype python nnoremap <buffer> <localleader>c I#<esc>
  autocmd Filetype html nnoremap <buffer> <localleader>c I<!-- <esc>A --><esc>0
  autocmd Filetype vim nnoremap <buffer> <localleader>c I"<esc>
  autocmd Filetype tex nnoremap <buffer> <localleader>c I%<esc>
augroup END
"}}}

"}}}


"{{{ Macros and Registers

let @t = ":!pdflatex --output-directory tex-out/ %\r"

"}}}
