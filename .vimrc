" ============VimPlug (Plugin Manager)============ "
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'godlygeek/tabular'
Plug 'vimwiki/vimwiki'
Plug '907th/vim-auto-save'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/indentLine'
" Supertab is needed for Ultisnips and deoplete to work well together
Plug 'ervandew/supertab'
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
let g:auto_save = 1  	    " enable AutoSave plugin on Vim startup
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1  " do not display the auto-save notification
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
set termguicolors           " Enable GUI colors for the terminal to get truecolor
set background=dark
let base16colorspace=256    " Access colors present in 256 colorspace
set hidden  " Change buffers without saving a buffer
set clipboard+=unnamedplus " Neovim requires xsel to be installed for foll to work
set relativenumber
set guicursor=  " Keep cursor constant in INSERT, NORMAL mode
set noshowmode " Doesn't show INSERT,NORMAL,VISUAL (It slows neovim)
set noshowcmd noruler   " Reduces speed if set
set number
set splitright
set splitbelow
set expandtab
set tabstop=4
set shiftwidth=4
set ignorecase
set noswapfile
set undofile " Undo file even after reopen
let g:indentLine_char = '┊'
let g:indentLine_fileTypeExclude = ['vimwiki']
let g:SuperTabDefaultCompletionType = "<c-n>"
let mapleader = " "
let maplocalleader = ","
" dynamic current window sizing from TBot Art of Vim
set winwidth=85
set winheight=20

" " ===========DEOPLETE and JEDI============= "
let g:jedi#completions_enabled = 0 " disable autocomplete for jedi-vim cause we use deoplete for completion
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = "0"
" let g:jedi#documentation_command = "D"
let g:jedi#goto_assignments_command = "<leader>a"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#goto_stubs_command = "<leader>c"
let g:jedi#use_splits_not_buffers = "right"
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_typeinfo = 0
let g:python3_host_prog = '/usr/bin/python'  " python interpreter for deoplete-jedi
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]


" " ========= AUTOCOMMANDS ========== "
" Enter/O/o doesn't created commented line when on commented line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Remembers the cursor position in file even after quiting it
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
" Python Specific
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
" function! Reload_mupdf()
"     !sleep 3 && pkill -HUP mupdf
" endfunction
" " Run Reload_mupdf() after writing the buffer to file
" au BufWritePost *.ms :call Reload_mupdf()
" Remove trailing whitespaces
autocmd BufWritePre *.py :%s/\s\+$//e


" " ========== REMAPS ========= "
" j and k work as expected even in long wrapped paragraphs
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
" execute current line as if a command. Better than q:
nnoremap <localleader>q :exe getline(line('.'))<cr>
" acts like dd but doesn't put anything in register
nnoremap s "_d
" codeblock in markdown
function CodeBlock()
    normal ohxi``````O 
endfunction
nnoremap <localleader>c :call CodeBlock()<CR>
" make words Bolds/italic for markdown
function! Bold(emphasis)
    let count = input("count = ") 
    if a:emphasis == "B"
        if count == ""
            execute "normal ys$*."
        else
            execute "normal ys" . count . "W*."
        endif
    else 
        if count == ""
            execute "normal ys$*.."
        else
            execute "normal ys" . count . "W*.."
        endif
    endif
endfunction
nnoremap <leader>w :call Bold("B")<CR>
nnoremap <leader>e :call Bold("BI")<CR>
" Indent newly added list item after pressing "o" markdown
inoremap <localleader>l <Esc>>>A
inoremap <localleader>h <Esc><<A
" <BS> is backspace
inoremap <localleader>a <BS><BS><CR>
" center after various jumps "zz"
nnoremap g; g;zz
nnoremap g, g,zz
" Following 1 line Just keep it
vnoremap K k
nnoremap <silent>u :silent undo<cr>
nnoremap <silent><C-r> :silent redo<cr>
" Sourcing .vimrc
nnoremap <silent><leader>sv :source $MYVIMRC<cr>
nnoremap <silent><leader>ev :vsplit $MYVIMRC<cr>
" Save files when not opened with sudo
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Remapping :w :wq :q and :q!
nnoremap <silent><leader>; :q!<cr>
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>s :silent w<cr>
nnoremap <leader>wq :wq<CR>
" jump between marks
nnoremap <C-n> :normal ]'zz <cr>
nnoremap <C-p> :normal ['zz <cr>
" Remove word highlighting
map <esc> :noh<cr>
" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Zoom a vim split
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
nnoremap <localleader>e :call Send_keys() <CR><CR>
nnoremap <C-o> <C-o>zz 
nnoremap <C-i> <C-i>zz 
nnoremap <leader>m :NERDTreeToggle<CR>


" " ========= FUNCTIONS =========== "
" send-keys to tmux pane
function! Send_keys()
    let name = expand('%:r')
    let input_file = join(["i", name, ".txt"], "")
    " % gives filename of the current buffer
    execute '!ts python3 % \< '.input_file
endfunction
" Buffer number in lightline
function! Bufno()
    return winwidth(0) > 70 ? bufnr('%') : ''
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
" command history
" nmap <leader>
" Search in hidden dir
let $FZF_DEFAULT_COMMAND = 'ag --depth 4 -p ~/.gitignore --hidden --ignore .git -l -g ""'
" Search and switch buffers
nmap <leader>b :Buffers <cr>
" Find files by name under the home directory
nmap <leader>h :Files ~/<cr>
" Files under current directory
nmap <leader>f :Files .<cr>
" Search content in loaded buffers
nmap <leader>l :Lines <cr>
" Search content in the current file and in files under the current directory
nmap <leader>g :Ag <cr>
" Search through command history
nmap <leader>c :History: <cr>


" " ======= COLORS ======== "
let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night_Bright',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename' , 'buffernumber', 'modified' ] ],
      \ 
      \   'right': [ [ 'percent', 'fileformat', 'fileencoding', 'filetype' ] ]
      \},
      \   'component_function': {
      \         'buffernumber': 'Bufno'
      \ },
      \ }
colorscheme base16-solarized-light
