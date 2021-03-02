let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +50 .zshrc
badd +1 .zshenv
badd +1 .gitignore
badd +242 .vimrc
badd +10 vimwiki/index.md
badd +1 vimwiki/Tasks.md
badd +15 vimwiki/Linux\ Book.md
badd +31 vimwiki/Redundant\ Stuff.md
badd +11 .scripts/c/test.c
badd +15 .scripts/c/test_calc.c
badd +71 .tmux.conf
badd +40 .config/neomutt/neomuttrc
badd +6 .config/neomutt/aliases
badd +89 .w3m/config
badd +101 .w3m/keymap
badd +1 .config/neomutt/vim-keys.rc
badd +15 .config/newsboat/urls
badd +27 .urlview
badd +12 .scripts/shell_scripts/urlview_handler.sh
badd +33 .config/newsboat/config
badd +8 vimwiki/Daily_basis_programs.md
badd +1 .config/surfraw/conf
badd +1 .config/polybar/config
argglobal
%argdel
$argadd .zshrc
edit .config/polybar/config
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=25 winwidth=85 winminheight=1 winminwidth=1 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
