let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 man://man(1)
badd +3 man://sddm(1)
badd +36 man://polybar(1)
badd +300 man://grep(1)
badd +68 man://w3m(1)
badd +253 man://feh(1)
badd +940 man://tmux(1)
badd +35 man://xbindkeys(1)
badd +279 man://xdotool(1)
badd +114 man://xsel(1x)
badd +44 .config/nvim/init.vim
badd +136 man://google-chrome-stable(1)
badd +1 man://gdb(1)
badd +211 man://xprop(1)
badd +48 man://xdg-open(1)
badd +1 man://xdg-mime(1)
badd +139 man://dmenu(1)
badd +43 man://xev(1)
badd +1 man://systool(1)
badd +124 man://xwininfo(1)
badd +19 man://locate(1)
argglobal
%argdel
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
enew
file man://locate(1)
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
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
