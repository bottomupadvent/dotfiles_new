"VimPlug (Plugin Manager)
call plug#begin()

" Plug 'ervandew/supertab'
Plug '907th/vim-auto-save'
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
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

let g:deoplete#sources#jedi#enable_typeinfo = 0
let g:python3_host_prog = '/usr/bin/python' 
" Write all buffers before navigating from Vim to tmux pane
let g:auto_save = 1  " enable AutoSave plugin on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification
"
" " For true colors in vim (Probably st terminal specific)
"
let g:deoplete#enable_at_startup = 1
" " set shell=zsh\ -i
" set mouse=a
set termguicolors                    " Enable GUI colors for the terminal to get truecolor
let base16colorspace=256  " Access colors present in 256 colorspace

set clipboard+=unnamedplus
" set textwidth=80
" set nowrap
" set nocompatible
" set timeoutlen=1000
" set ttimeoutlen=0
" syntax on
" syntax enable
"
" " set cursorline
" filetype plugin on
" filetype on
" filetype indent on
" filetype plugin indent on
set relativenumber
set number
" set laststatus=2
" set encoding=utf-8
" set noshowmode
" set fillchars=vert:│
" set softtabstop=4
" set expandtab
" set tabstop=4
" set shiftwidth=4
" set nocursorline
" set nocursorcolumn
" set scrolljump=5
" set lazyredraw
" " synmaxcol can be anynumber
" set synmaxcol=180
" set autoindent
" " set foldmethod=manual
" set foldlevel=99
" set signcolumn=yes
" set scrolloff=5
set ignorecase
" set smartcase
" set smarttab
" set hidden
" set showmode
" set noswapfile
" set incsearch
" set splitright
" set splitbelow
" set visualbell t_vb=
" " dynamic current window sizing from TBot Art of Vim
" " set winwidth=95
" " set winheight=30
"
" " helper for indent mistake
set list listchars=tab:»·,trail:·
" Python Specific
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
"
" " Remove trailing whitespaces
" autocmd BufWritePre *.py :%s/\s\+$//e

" " Leader and Local-leader
let mapleader = " "
let maplocalleader = ","

" " Sourcing .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Save files when not opened with sudo
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" " Go to tab by number
" noremap <leader>1 1gt
" noremap <leader>2 2gt
" noremap <leader>3 3gt
" noremap <leader>4 4gt
" noremap <leader>5 5gt

" " Go to last active tab
" au TabLeave * let g:lasttab = tabpagenr()
" nnoremap <silent> <leader>n :exe "tabn ".g:lasttab<cr>
" vnoremap <silent> <leader>n :exe "tabn ".g:lasttab<cr>
"
" " Remapping :q :w :wq and :q!
nnoremap <leader>q :q<cr>
nnoremap <leader>; :q!<cr>
nnoremap <leader>wq :wq<CR>
"
" Remove word highlighting
nnoremap <localleader>. :noh<cr>

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" send-keys to tmux pane
function! Send_keys()
    let name = expand('%:r')
    let input_file = join(["i", name, ".txt"], "")
    " % gives filename of the current buffer
    execute '!ts python3 % \< '.input_file
endfunction

nnoremap <localleader>e :call Send_keys() <CR><CR>

" " Plugin Toggles
" Switch between the last two files
nnoremap <leader><leader> <c-^>

" " Resize splits
" nnoremap <silent> <Right> :vertical resize +5<cr>
" nnoremap <silent> <Left> :vertical resize -5<cr>
" nnoremap <silent> <Up> :resize +5<cr>
" nnoremap <silent> <Down> :resize -5<cr>

" Zoom a vim split
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" " Switching tabs
" " map <C-p> :tabp<cr>
" " map <C-n> :tabN<cr>
"
" " ============ Easy motion ==============="
map <leader> <Plug>(easymotion-prefix)
let g:EasyMotion_smartcase = 1
" " Jump to anywhere you want with minimal keystrokes, with just one key binding.
" " `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" " Set Paste
" set pastetoggle=<F11>

" "Ultisnips snippets 
"
" " function! g:UltiSnips_Complete()
" "     call UltiSnips#ExpandSnippet()
" "     if g:ulti_expand_res == 0
" "         if pumvisible()
" "             return "\<C-n>"
" "         else
" "             call UltiSnips#JumpForwards()
" "             if g:ulti_jump_forwards_res == 0
" "                return "\<TAB>"
" "             endif
" "         endif
" "     endif
" "     return ""
" " endfunction
"
"
" " let g:UltiSnipsListSnippets="<c-e>"

" " this mapping Enter key to <C-y> to chose the current highlight item
" " and close the selection list, same as other IDEs.
" " CONFLICT with some plugins like tpope/Endwise
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" let g:SuperTabDefaultCompletionType = '<C-n>'

" map <F7> :UltiSnipsEdit<CR>
" let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips/']
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" " Jedi Autocomplete
" " let g:jedi#goto_assignments_command = ""
" " let g:jedi#auto_initialization = 0
" " let g:jedi#completions_enabled = 0
" " autocmd FileType python setlocal completeopt-=preview
" " let g:jedi#popup_select_first = 0
" " let g:jedi#show_call_signatures = "0"
" "
" " let g:jedi#popup_on_dot = 0
" " let g:SuperTabDefaultCompletionType = ""
" " nnoremap <leader>d :call jedi#goto()<cr>
" " nnoremap <leader>a :call jedi#goto_assignments()<cr>
" " " j and k to scroll completions jedi.vim
" " inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
" " inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
"
" " Jumps using j and k and C-o and C-tab to switch between
" nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
" nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'
"
"
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

colorscheme base16-material-darker
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }
