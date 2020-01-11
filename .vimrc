"VimPlug (Plugin Manager)
call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'honza/vim-snippets'
Plug 'jaxbot/browserlink.vim'
Plug 'SirVer/ultisnips'
Plug 'chriskempson/base16-vim'
Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-syntastic/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-obsession'
" used to autoread a vim buffer if the file is changed outside of vim
" Note - This plugin only works if a command is triggered within tmux.
Plug 'tmux-plugins/vim-tmux-focus-events'

call plug#end()


" For true colors in vim (Probably st terminal specific)

set termguicolors                    " Enable GUI colors for the terminal to get truecolor
set t_Co=256                         " Enable 256 colors
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm
set t_8f=[38;2;%lu;%lu;%lum        " set foreground color
set t_8b=[48;2;%lu;%lu;%lum        " set background color
set background=dark

" Setting variables
set viewoptions=cursor,folds,slash,unix
" set list
" set listchars=trail:~
set clipboard=unnamedplus
set textwidth=80
set nowrap
set nocompatible
set timeoutlen=300
set ttimeoutlen=0
syntax on
set cursorline
filetype plugin on
filetype on
filetype indent on
filetype plugin indent on
set relativenumber
set number
set laststatus=2
set encoding=utf-8
set noshowmode
set fillchars=vert:│
set softtabstop=4
set expandtab
set tabstop=4
set shiftwidth=4
" set autoindent
set foldmethod=manual
set foldlevel=99
set signcolumn=yes
set scrolloff=5
set ignorecase
set smartcase
set smarttab
set hidden
set showmode
set noswapfile
set incsearch
set splitright
set splitbelow
set visualbell t_vb=
" dynamic current window sizing from TBot Art of Vim
set winwidth=95
set winheight=30

" Python Specific
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent

" Remove trailing whitespaces
autocmd BufWritePre *.py :%s/\s\+$//e

" Disable automatic commenting lines after <return>
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Leader and Local-leader
let mapleader = " "
let maplocalleader = ","



" Sourcing .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Save files when not opened with sudo
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Remapping :q :w :wq and :q!
nnoremap <leader>q :q<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>; :q!<cr>
nnoremap <leader>wq :wq<CR>

" Remove word highlighting
nnoremap <localleader>. :noh<cr>

" Remove trailing whitespace
nnoremap <localleader>w :%s/\s\+$//e <cr>

" Plugin Toggles
nnoremap <leader>go :Goyo <CR>
nnoremap <leader>m :NERDTreeToggle<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Switching Splits
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Resize splits
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>
" Zoom a vim split
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
" Switching tabs
map <C-p> :tabp<cr>
map <C-n> :tabN<cr>

" Set Paste
set pastetoggle=<F11>

" Syntastic
set statusline+=%%#warningmsg#
set statusline+=%%{SyntasticStatuslineFlag()}
set statusline+=%%*
map <localleader>s :SyntasticToggleMode<cr>
" let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"Ultisnips snippets 

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let g:UltiSnipsExpandTrigger = "<tab>"

" You Complete me
" let g:ycm_global_ycm_extra_conf = '/home/sols/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

nnoremap <leader>d :YcmCompleter GoToDefinition <cr>

let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
" Jedi Autocomplete
" let g:jedi#goto_assignments_command = ""
" let g:jedi#auto_initialization = 0
" let g:jedi#completions_enabled = 0
" autocmd FileType python setlocal completeopt-=preview
" let g:jedi#popup_select_first = 0
" let g:jedi#show_call_signatures = "0"
"
" let g:jedi#popup_on_dot = 0
" let g:SuperTabDefaultCompletionType = ""
" nnoremap <leader>d :call jedi#goto()<cr>
" nnoremap <leader>a :call jedi#goto_assignments()<cr>
" " j and k to scroll completions jedi.vim
" inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
" inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" Jumps using j and k and C-o and C-tab to switch between
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'


" FZF
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

let python_highlight_all = 1
colorscheme base16-material-darker
" " Lighline Status line
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
" color PaperColor

" C++ syntax plugin 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1


" HTML settings (youcompleteme)

augroup css
    autocmd!
    autocmd FileType css,html setlocal iskeyword+=-
augroup END

" Emmet settings

" Do the following only for .html and .css files
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Autocomplete key to for emmet is ",,"
let g:user_emmet_leader_key=','


" Trigger vim's autocomplete engine(Omnifunc) as youcomplete me does not have its own semantic engine support for css files
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^\s{4}', 're!:\s+' ],
    \ }
