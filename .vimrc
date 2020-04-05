" ============VimPlug (Plugin Manager)============ "
call plug#begin()
Plug '907th/vim-auto-save'
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
" deoplete provides async autocompletions
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" deoplete-jedi is specific for async python autocompletions
Plug 'deoplete-plugins/deoplete-jedi'
" jedi-vim = deoplete-jedi but deoplete-jedi can't jump to definitions, declarations etc
" and that is why I use jedi-vim for in the below config(definitions and declarations)
Plug 'davidhalter/jedi-vim'
Plug 'SirVer/ultisnips'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'vim-syntastic/syntastic'
Plug 'tomtom/tcomment_vim'
" Plug 'tpope/vim-obsession'
" used to autoread a vim buffer if the file is changed outside of vim
" Note - This plugin only works if a command is triggered within tmux.
" Plug 'tmux-plugins/vim-tmux-focus-events'
call plug#end()

" "==========BASIC LET AND SET==========="
let g:auto_save = 0  	    " enable AutoSave plugin on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
set termguicolors           " Enable GUI colors for the terminal to get truecolor
let base16colorspace=256    " Access colors present in 256 colorspace
set clipboard=unnamedplus
set relativenumber
set guicursor=
" Doesn't show INSERT,NORMAL,VISUAL (It slows neovim)
set noshowmode
" Following 2 reduces speed if set
set noshowcmd
set noruler
set number
set splitright
set splitbelow
set expandtab
set tabstop=4
set shiftwidth=4
set ignorecase
set noswapfile
" Undo file even after reopen
set undofile
" dynamic current window sizing from TBot Art of Vim
" set winwidth=95
" set winheight=30

" " ===========DEOPLETE and JEDI============= "
" Enter key on commented line doesn't create another commented line
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" disable autocompletion for jedi-vim cause we use deoplete for completion
let g:jedi#completions_enabled = 0
let g:jedi#goto_assignments_command = "<leader>a"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#goto_stubs_command = "<leader>c"
let g:jedi#use_splits_not_buffers = "right"
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_typeinfo = 0
let g:python3_host_prog = '/usr/bin/python'  " python interpreter for deoplete-jedi

" " ========= AUTOCOMMANDS ========== "
" Following 2 options : Enter/O/o doesn't created commented line when on commented line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Remembers the cursor position in file even after quiting it
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
" Python Specific
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
" Remove trailing whitespaces
autocmd BufWritePre *.py :%s/\s\+$//e

" " ========== REMAPS ========= "
" Leader and Local-leader
let mapleader = " "
let maplocalleader = ","
" Sourcing .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Save files when not opened with sudo
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Remapping :w :wq :q and :q!
nnoremap <leader>; :q!<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>wq :wq<CR>
" jump between marks
nnoremap <M-n> :normal ]' <cr>
nnoremap <M-p> :normal [' <cr>

" Remove word highlighting
map <esc> :noh<cr>
" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Zoom a vim split
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
nnoremap <localleader>e :call Send_keys() <CR><CR>


" " ========= FUNCTIONS =========== "
" send-keys to tmux pane
function! Send_keys()
    let name = expand('%:r')
    let input_file = join(["i", name, ".txt"], "")
    " % gives filename of the current buffer
    execute '!ts python3 % \< '.input_file
endfunction

" " ============ EASY MOTION =============== "
map <localleader> <Plug>(easymotion-prefix)
let g:EasyMotion_smartcase = 1

" " ============ ULTISNIPS ================ "
map <F7> :UltiSnipsEdit<CR>
let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips/']
" let g:UltiSnipsListSnippets="<c-e>"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" " =========== FZF ============ "
" Search in hidden dir
let $FZF_DEFAULT_COMMAND = 'ag --hidden -p ~/.agignore --ignore .git -l -g ""'
" Search and switch buffers
nmap <leader>b :Buffers<cr>
" Find files by name under the current directory
nmap <leader>f :Files<cr>
" Find files by name under the home directory
nmap <leader>h :Files ~/<cr>
" Find files from root dir recursively
nmap <leader>r :Files /<cr>
" Search content in the current file
nmap <leader>l :Lines<cr>
" Search content in the current file and in files under the current directory
nmap <leader>g :Ag<cr>


" " ======= COLORS ======== "
colorscheme base16-material-darker
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename' , 'buffernumber', 'modified' ] ],
      \ 
      \   'right': [ [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \},
      \   'component_function': {
      \         'buffernumber': 'Bufno'
      \ },
      \ }

" Buffer number in lightline
function! Bufno()
  return winwidth(0) > 70 ? bufnr('%') : ''
endfunction
