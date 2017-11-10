" Defaults
source $VIMRUNTIME/defaults.vim

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file (restore to previous version)
	if has('persistent_undo')
		set undofile	" keep an undo file (undo changes after closing)
	endif
endif

if &t_Co > 2 || has("gui_running")
	" Switch on highlighting the last used search pattern.
	set hlsearch
endif

"" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
	au!

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78

	augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

"" Add optional packages.
if has('syntax') && has('eval')
	packadd matchit
endif

" Font
set guifont="Inconsolata-g"

" Options
set nocompatible      " Disables vi compatibility-mode
set number            " Show line numbers
set showcmd           " Shows input before it is completed
set wildmenu          " Status line shows possible completions
set noerrorbells      " Turns off bell
set tabstop=4         " Tabs are 4-spaces-wide
set softtabstop=0     " Does not use soft Tabs
set shiftwidth=4      " Indentation is 4-spaces-wide
set noexpandtab       " Does not expand Tabs to spaces
set nostartofline     " Cursor doesn't change columns when changing lines
set autoindent        " Uses same indentation in a new line
set incsearch         " Searches befores input is completed
set backspace=2       " Moves cursors through identation and eol
set shortmess=at      " Shortens all messages
set whichwrap=<,>,h,l " Commands that can jump to next line when eol
set laststatus=2      " Always shows status line
set diffopt=vertical  " Vimdiff will open windows with vertical split
set title             " Show current file title
set conceallevel=2    " Enable syntax concealing

" Mappings and functionalities
"" Ctrl-L erases the last search buffer
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

"" TABs and trails are shown
set list
set lcs=tab:»-
set lcs+=trail:~

"" Shows 5 lines in advance when scrolling to the end of the screen
if !&scrolloff
	set scrolloff=1
endif
if !&sidescrolloff
	set sidescrolloff=5
endif
set display+=lastline

"" Saves previous session of the file (searches, dos, commands)
set vi=%,'50
set vi+=\"100,:100
set vi+=n~/.viminfo

"" Allow saving of files as sudo
cmap W!! w !sudo tee > /dev/null %

"" Writing mode
func! WordProcessorMode()
  setlocal formatoptions=1
  setlocal noexpandtab
  map j gj
  map k gk
  setlocal spell spelllang=en_us
  set thesaurus+=.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap
  setlocal linebreak
endfu
com! WP call WordProcessorMode()
augroup wpmode
  autocmd!
  autocmd FileType markdown,mkd call WordProcessorMode()
  autocmd FileType textile call WordProcessorMode()
  autocmd FileType text call WordProcessorMode()
  autocmd FileType vimwiki call WordProcessorMode()
augroup END

"" Show word count
function! WordCount()
  let s:old_status = v:statusmsg
  let position = getpos(".")
  exe ":silent normal g\<c-g>"
  let stat = v:statusmsg
  let s:word_count = 0
  if stat != '--No lines in buffer--'
    let s:word_count = str2nr(split(v:statusmsg)[11])
    let v:statusmsg = s:old_status
  end
  call setpos('.', position)
  return s:word_count 
endfunction

"" Functions that refresh ctags when writing a file
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction
function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()

" Color
set background=light
colorscheme solarized
let g:solarized_termcolors=16
let g:solarized_contrast="normal"

" Statusline setup
"" Default start
set statusline=%f\ %h%w%m%r
"" Show filetype
set statusline+=%y
"" End
set statusline+=%=%{WordCount()}
set statusline+=%=%(\ \ %l,%c%V\ %=\ %P%)

" Verilog setup
"" Function to set verilog indentation
function! Vindent()
	setlocal tabstop=3
	setlocal softtabstop=3
	setlocal shiftwidth=3
	setlocal expandtab
endfunction

"" Function to set verilog line wrapping
function! Vwrap()
	setlocal textwidth=80
	setlocal formatoptions+=t
endfunction

"" Run those opening a verilog file
augroup verilog_autocmds
	au!
	" Applies functions automatically
	autocmd FileType verilog_systemverilog call Vindent()
	autocmd FileType verilog_systemverilog call Vwrap()
	" Highlights line limit at 80 char
	autocmd FileType verilog_systemverilog highlight OverLength ctermbg=DarkGrey ctermfg=White guibg=DarkGrey
	autocmd FileType verilog_systemverilog match OverLength /\%81v.*/
augroup END

" Plugin configurations
"" Adds syntax for plugin filetype
filetype plugin indent on
syntax on

"" Allows use of % to jump between keywords
runtime macros/matchit.vim

"" Maps NERDTree sidebar
map <C-n> :NERDTreeToggle<CR>

"" Context-related TAB completion
let g:SuperTabDefaultCompletionType = 'context'

"" Maps Tag Tree sidebar
nmap <C-t> :TagbarToggle<CR>

"" Default pdf viewer for vimtex
let g:vimtex_view_method = 'zathura'

"" Activate spell check on some filetypes
augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init()
  autocmd FileType vimwiki call lexical#init()
augroup END

"" Activate autocorrect on some filetypes
augroup autocorrect
  autocmd!
  autocmd FileType markdown,mkd call AutoCorrect()
  autocmd FileType textile call AutoCorrect()
  autocmd FileType text call AutoCorrect()
  autocmd FileType vimwiki call AutoCorrect()
augroup END

"" Calendar sync options
let g:calendar_google_calendar = 1
let g:calendar_google_task     = 1
let g:calendar_views           = ['year', 'month', 'week', 'day_4', 'day', 'clock', 'event', 'agenda']
let g:calendar_cyclic_view     = 1
let g:calendar_task            = 1

"" Markdown & pandoc configurations
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType vimwiki set filetype=pandoc

"" Wiki behavior
let wiki_default = {}
let wiki_default.auto_export = 0
let wiki_default.auto_toc = 1
let wiki_default.auto_tags = 1
let wiki_default.syntax = 'markdown'
let wiki_default.ext = '.md'
let wiki_default.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'sh': 'sh'}

let wiki_main = copy(wiki_default)
let wiki_main.path = '~/vimwiki/'
let wiki_main.index = 'index'
let wiki_main.diary_index = 'diary'
let wiki_main.diary_rel_path = 'diary/'

let wiki_nape = copy(wiki_default)
let wiki_nape.path = '~/nape/wiki/'
let wiki_nape.index = 'nape'
let wiki_nape.diary_index = 'diary_nape'
let wiki_nape.diary_rel_path = 'diary/'

let g:vimwiki_list = [wiki_main, wiki_nape]
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {'.md': 'markdown',
                          \ '.mkd': 'markdown',
                          \ '.wiki': 'markdown'}

"" Pencil configuration
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
  autocmd FileType textile      call pencil#init()
  autocmd FileType vimwiki      call pencil#init()
augroup END

"" View options
set viewoptions=cursor,folds,slash,unix

" Plugins
call plug#begin('~/.vim/plugged')
"" base16-vim: base-16 colors
Plug 'chriskempson/base16-vim'
"" syntastic: check syntax errors
Plug 'vim-syntastic/syntastic'
"" tabular: table editing
Plug 'godlygeek/tabular'
"" vim-surround: surround words, phrases and selecition into delimiters
Plug 'tpope/vim-surround'
"" vim-repeat: allows repeating for many addons
Plug 'tpope/vim-repeat'
"" vim-fugitive: git tools
Plug 'tpope/vim-fugitive'
"" goyo.vim: pretty reading mode
Plug 'junegunn/goyo.vim'
"" vimpager: reads output of many commands using vim
Plug 'rkitover/vimpager'
"" nerdtree-git-plugin: git enhancements for NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'
"" vim-fanfingtastic: enhances f and t commands
Plug 'dahu/vim-fanfingtastic'
"" nerdtree: directory and files tree inside vim
Plug 'scrooloose/nerdtree', {'on':  'NERDTreeToggle'}
"" verilog_systemverilog.vim: verilog editing enhancements
Plug 'vhda/verilog_systemverilog.vim'
"" hl_matchit.vim: highlights matching keywords as well
Plug 'vimtaku/hl_matchit.vim'
"" supertab: allows use of TAB to perform insert completion
Plug 'ervandew/supertab'
"" tagbar: sidebar to display tag tree
Plug 'majutsushi/tagbar'
"" FastFold: sets automatic folds to manual in some scenarios to speed up
Plug 'Konfekt/FastFold'
"" dbext.vim: universal database command integration
Plug 'vim-scripts/dbext.vim'
"" vim-rails: rails integration
Plug 'tpope/vim-rails'
"" vim-rake: support for ruby projects outside rails
Plug 'tpope/vim-rake'
"" vim-sleuth: automatically guesses indentation
Plug 'tpope/vim-sleuth'
"" gv.vim: interactive git log
Plug 'junegunn/gv.vim'
"" vimtex: latex editing tool
Plug 'lervag/vimtex'
"" vim-colors-pencil: light color theme
Plug 'reedes/vim-colors-pencil'
"" vim-gitgutter: show git diffs
Plug 'airblade/vim-gitgutter'
"" vim-lexical: spell-check and thesaurus
Plug 'reedes/vim-lexical'
"" vim-autocorrect: autocorrect
Plug 'panozzaj/vim-autocorrect'
"" vim-wheel: wheel moviment
Plug 'reedes/vim-wheel'
"" Colorizer: color visualizer
Plug 'chrisbra/Colorizer'
"" papercolor-theme: another light theme
Plug 'NLKNguyen/papercolor-theme'
"" restore_view.vim: saves folds and cursor position
Plug 'vim-scripts/restore_view.vim'
"" vim-calendar: calendar integration
Plug 'itchyny/calendar.vim'
"" vimwiki: personal outline organization
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
"" vim-online-thesaurus: online synonym finder
Plug 'beloglazov/vim-online-thesaurus'
"" vim-misc: miscellaneous functionalities
Plug 'xolox/vim-misc'
"" vim-pandoc: integration with pandoc
Plug 'vim-pandoc/vim-pandoc'
"" vim-pencil: improves writing
Plug 'reedes/vim-pencil'
"" vim-obssession: session funcionality
Plug 'tpope/vim-obsession'
"" vim-pandoc-syntax: full array of pandoc syntax
Plug 'vim-pandoc/vim-pandoc-syntax'
call plug#end()
