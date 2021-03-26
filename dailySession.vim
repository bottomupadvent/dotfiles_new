let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +106 .zshrc
badd +21 .zshenv
badd +1 .gitignore
badd +1 .vimrc
badd +1 vimwiki/index.md
badd +1 vimwiki/Tasks.md
badd +630 vimwiki/Linux\ Book.md
badd +12 vimwiki/Redundant\ Stuff.md
badd +11 .scripts/c/test.c
badd +15 .scripts/c/test_calc.c
badd +83 .tmux.conf
badd +40 .config/neomutt/neomuttrc
badd +6 .config/neomutt/aliases
badd +82 .w3m/config
badd +1 .w3m/keymap
badd +1 .config/neomutt/vim-keys.rc
badd +15 .config/newsboat/urls
badd +27 .urlview
badd +25 .scripts/shell_scripts/urlview_handler.sh
badd +33 .config/newsboat/config
badd +9 vimwiki/Daily_basis_programs.md
badd +1 .config/surfraw/conf
badd +16 .config/polybar/config
badd +49 .w3m/cgi-bin/fzf_surfraw.cgi
badd +10 .config/polybar/launch.sh
badd +78 .xbindkeysrc
badd +9 .scripts/shell_scripts/gui_webpage_to_w3m.sh
badd +1 .config/mimeapps.list
badd +1 vimwiki/Baba.md
badd +25 vimwiki/Geeta_Notes.md
badd +1 vimwiki/Future.md
badd +161 .tmux/plugins/tmux-sensible/sensible.tmux
badd +1 vimwiki/Linux_Read.md
badd +17 .tmux/plugins/vim-tmux-navigator/vim-tmux-navigator.tmux
badd +1 vimwiki/College.md
badd +64 vimwiki/Aai.md
badd +13 Source/st/config.h
badd +254 .config/i3/config
badd +21 .config/qutebrowser/config.py
badd +23 .Xresources
badd +5 vimwiki/Configs\ Stuff.md
badd +2 .config/nvim/coc-settings.json
argglobal
%argdel
$argadd .zshrc
edit .config/qutebrowser/config.py
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
let s:l = 21 - ((12 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
21
normal! 0
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=25 winwidth=85 winminheight=1 winminwidth=1 shortmess=filnxtToOFc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
