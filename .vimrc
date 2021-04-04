" ============VimPlug (Plugin Manager)============ "
call plug#begin()
Plug 'preservim/nerdtree'
" Write to non writable files
Plug 'chrisbra/Colorizer'
Plug 'preservim/tagbar'
Plug 'mcchrish/nnn.vim'
Plug 'godlygeek/tabular'
Plug 'vimwiki/vimwiki'
" Plug '907th/vim-auto-save'
Plug 'easymotion/vim-easymotion'
" Supertab is needed for Ultisnips and deoplete to work well together
" Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" deoplete provides async autocompletions
" ----------------- Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" clang_complete provides autocompletions for c/c++
" Plug 'xavierd/clang_complete'
" deoplete-jedi is specific for async python autocompletions
" ----------------- Plug 'deoplete-plugins/deoplete-jedi'
" jedi-vim = deoplete-jedi but deoplete-jedi can't jump to definitions, declarations etc
" and that is why I use jedi-vim for in the below config(definitions and declarations)
" ----------------- Plug 'davidhalter/jedi-vim'
" ----------------- Plug 'SirVer/ultisnips'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'Raimondi/delimitMate'
" Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'vim-syntastic/syntastic'
Plug 'tomtom/tcomment_vim'
" Plug 'tpope/vim-obsession'
" used to autoread a vim buffer if the file is changed outside of vim
" Note - This plugin only works if a command is triggered within tmux.
Plug 'tmux-plugins/vim-tmux-focus-events'

call plug#end()

" "==========BASIC LET AND SET==========="
"" statusline
set statusline                          " left align

" let g:clang_library_path='/usr/lib64/libclang.so.11.1'
" let g:suda#prompt = 'Password: '
" let g:suda_smart_edit = 1
let g:man_hardwrap = $MANWIDTH

" " COC nvim config "
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <localleader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <localleader>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <localleader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <localleader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <localleader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <localleader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <localleader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <localleader>p  :<C-u>CocListResume<CR>

" Use tab for snippets completion (For coc-snippets)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction




" let g:auto_save = 1  	    " enable AutoSave plugin on Vim startup
" let g:auto_save_events = ["InsertLeave", "TextChanged"]
" let g:auto_save_silent = 1  " do not display the auto-save notification

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 0
set termguicolors           " Enable GUI colors for the terminal to get truecolor
set cursorline
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
set mouse=nv
let mapleader = " "
let maplocalleader = '\'
" dynamic current window sizing from TBot Art of Vim
" set winwidth=90
" set winheight=25


let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]


" Floating window (neovim latest and vim with patch 8.2.191)
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }

" " ========= AUTOCOMMANDS ========== "
augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

" autocmd FileType md call deoplete#custom#buffer_option('auto_complete', v:false) set g:loaded_python3_provider = 0

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
nnoremap <leader>m :Man 
nnoremap n nzz
nnoremap N Nzz
" "_d register does not copy content to system clipboard
" nnoremap d "_d
nmap <F8> :TagbarToggle<CR>
nnoremap ]] ]]zz
" j and k work as expected even in long wrapped paragraphs
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
" execute current line as if a command. Better than q:
nnoremap <localleader>q :exe getline(line('.'))<cr>
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
" " Search for visual selected words " 
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap <silent>u :silent undo<cr>
nnoremap <silent><C-r> :silent redo<cr>
" Sourcing .vimrc
nnoremap <silent><leader>sv :source $MYVIMRC<cr>
nnoremap <silent><leader>ev :vsplit $MYVIMRC<cr>
" Save files when not opened with sudo (Doesn't work with neovim)
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Remapping :w :wq :q and :q!
nnoremap <silent><leader>; :q!<cr>
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>s :silent w<cr>
nnoremap <leader>wq :wq<CR>
" jump between marks
" nnoremap <C-n> :normal ]'zz <cr>
" Remove word highlighting
map <esc> :noh<cr>
" Uppercase 
" nnoremap <C-w> <Esc>gUiw`]
" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Zoom a vim split
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
nnoremap <localleader>e :call Send_keys() <CR><CR>
nnoremap <C-o> <C-o>zz 
nnoremap <C-i> <C-i>zz 
nnoremap <leader>M :NERDTreeToggle<CR>


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
" map <F7> :UltiSnipsEdit<CR>
" let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips/']
" " let g:UltiSnipsListSnippets="<c-e>"
" let g:UltiSnipsExpandTrigger = "<c-tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" " =========== FZF ============ "
" command history
" nmap <leader>
" Search in hidden dir
let $FZF_DEFAULT_COMMAND = 'ag --depth 5 -p ~/.gitignore --hidden --ignore .git -l -g ""'
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
" Search thru search history
nmap <leader>C :call fzf#vim#search_history() <cr>




" " ======= COLORS ======== "
" let g:lightline = {
"       \ 'colorscheme': 'nord',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename' , 'buffernumber', 'modified' ] ],
"       \ 
"       \   'right': [ [ 'percent', 'fileformat', 'fileencoding', 'filetype' ] ]
"       \},
"       \   'component_function': {
"       \         'buffernumber': 'Bufno'
"       \ },
"       \ }
colorscheme base16-nord
