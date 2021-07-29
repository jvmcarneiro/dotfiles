" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Current color theme
Plug 'fneu/breezy'
" Color names and hex codes
Plug 'chrisbra/Colorizer'
" Tree folder navigation panel
Plug 'scrooloose/nerdtree'
" Nerdtree support for git flags
Plug 'Xuyuanp/nerdtree-git-plugin'
" Fancy status line
Plug 'itchyny/lightline.vim'
" Indentation detection
Plug 'tpope/vim-sleuth'
" Bindings for surrounded stuff
Plug 'tpope/vim-surround'
" Extended repeat
Plug 'tpope/vim-repeat'
" Extra mappings
Plug 'tpope/vim-unimpaired'
" Git integration
Plug 'tpope/vim-fugitive'
" Universal syntax highlighting
Plug 'sheerun/vim-polyglot'
" Latex syntax and tools
Plug 'lervag/vimtex'
" Snippet collection
Plug 'honza/vim-snippets'
" Snippet engine
Plug 'SirVer/ultisnips'
" Auto completion engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Python completion
Plug 'deoplete-plugins/deoplete-jedi'
" Syntax checker
Plug 'dense-analysis/ale'
" Checker indicators
Plug 'maximbaz/lightline-ale'
" Portuguese spell checking
Plug 'mateusbraga/vim-spell-pt-br'
" Initialize plugin system
call plug#end()

" Remember last cursor position
augroup lastposition
  autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' &&
        \ line("'\"") > 1 && line("'\"") <= line("$") | 
        \exe "normal! g`\"" | endif 
augroup END

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

" Enables mouse support
set mouse=a

" Wrap navigation commands over lines
set whichwrap+=<,>,h,l,[,]

" Open tree navigation
nnoremap <C-n> :NERDTreeToggle<CR>

" Treat display lines as normal
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

" Simplify window navigation
map <C-j> <c-w>j
map <C-k> <c-w>k
map <C-h> <c-w>h
map <C-l> <c-w>l

" Maps enter to clear search highlighting
nnoremap <C-\> :noh<CR><CR>

" Set current theme
syntax enable
set background=light
if has('termguicolors')
  set termguicolors
endif
colorscheme breezy
let python_highlight_all=1

" Completion config
let g:deoplete#enable_at_startup = 1
set completeopt-=preview
call deoplete#custom#option('sources', {
		\ '_': ['buffer', 'file', 'omni', 'ale'],
		\})
call deoplete#custom#source('_', 'smart_case', v:true)
inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:UltiSnipsExpandTrigger = '<nop>'
inoremap <expr> <CR> pumvisible() ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\<CR>"
let g:UltiSnipsJumpForwardTrigger  = '<c-e>'
let g:UltiSnipsJumpBackwardTrigger = '<c-a>'

" Latex configuration
augroup text_files
  au BufReadPost,BufNewFile *.md,*.txt,*.tex setlocal spell
augroup END
set spelllang=pt_br,en_us
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_fold_enabled = 1

" Quickfix windows adaptable size
augroup quickfix_autocmds
  autocmd!
  autocmd BufReadPost quickfix call AdjustWindowHeight(2, 30)
augroup END
function! AdjustWindowHeight(minheight, maxheight)
  execute max([a:minheight, min([line('$') + 1, a:maxheight])])
        \ . 'wincmd _'
endfunction

" Backup config
set undofile
set directory^=~/.nvim/undo/
set swapfile
set directory^=~/.nvim/swap/
set backup
set writebackup
set backupcopy=auto
set backupdir^=~/.nvim/backup/

" Terminal Config
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec 'resize ' . a:height
        try
            exec 'buffer ' . g:term_buf
        catch
            call termopen($SHELL, {'detach': 0})
            let g:term_buf = bufnr('')
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction
nnoremap <C-t> :call TermToggle(12)<CR>
inoremap <C-t> <Esc>:call TermToggle(12)<CR>
tnoremap <C-t> <C-\><C-n>:call TermToggle(12)<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" Lightline config
let g:lightline = {
      \ 'colorscheme': 'breezy',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
      \              [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2c%<',
      \   'filename': '%t%<',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"
