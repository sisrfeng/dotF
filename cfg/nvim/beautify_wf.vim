" [[---------------------------------------Theme Settings    主题设置
" source  ~/.local/share/nvim/plugged/vim-solarized8/colors/solarized8.vim
" set background=light
"
" if !exists('g:vscode')
"     autocmd vimenter * ++nested colorscheme solarized8 | hi CursorLine guibg=#e3efe3 |  hi Cursor guibg=#ffff7c
" endif
"
source ~/dotF/cfg/nvim/paperlike_wf.vim


set background=light

if !exists('g:vscode')
    colorscheme lucius
    LuciusLight
    hi Normal guibg=NONE
    hi Menu   guibg=#abefcd  guifg=#123456
    highlight Pmenu guibg=#ede6d3

    " 背景米白色
    let g:rice_white_wf='#fdf6e3'
    hi Comment guifg=rice_white | let g:hidden = 1
            func! Comment_01()
                if g:hidden == 1
                    " hi Comment guifg=#654900 gui=reverse
                    hi Comment guifg=background guibg=#ede6d3
                    let g:hidden = 0
                else
                    hi Comment guifg=#fdf6e3 guibg=none
                    let g:hidden = 1
                endif
            endfunc
    nnoremap <leader>c :call Comment_01()<CR>
endif

" if &diff
    " hi DiffAdd    guifg=#003300 guibg=#DDFFDD gui=none
    " hi DiffChange guibg=#ececec gui=none
    " hi DiffText   guifg=#000033 guibg=#DDDDFF gui=none
" endif

autocmd BufWritePost * if &diff == 1 | diffupdate | endif

" nnoremap csc :set cursorcolumn?<CR>
    " 手动敲吧
hi cursorcolumn guibg=rice_white_wf guifg=#00a253


hi ErrorMsg guifg=#835000


highlight Folded guibg=rice_white_wf guifg=#ada693
" highlight FoldColumn guibg=darkgrey guifg=white

set cursorline
hi CursorLine gui=bold guifg=none guibg=none

    " hi CursorLine guibg=rice_white_wf gui=undercurl
    " syn match underscore "_"
    " hi underscore gui=reverse
hi Visual  guifg=rice_white_wf guibg=#dde6d3 gui=bold


set termguicolors
    " 从前：For terminal Vim, with colors, we're most interested in the cterm
    " 现在可以在TUI下用gui的颜色: true (24-bit) colours.
    " 下面改颜色只用改 guibg guif

" 放文件前部分不行
" hi Search guibg=#afafef guifg=#00aeae
hi Search guifg=black guibg=#edefd3

" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1  " 被下面的代替了
" mobaxterm里insert mode还是方块。vscode里是正常的
set guicursor=n-v-c:block,
            \i-ci-ve:ver25,
            \r-cr:hor20,
            \o:hor50
            \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
            \,sm:block-blinkwait175-blinkoff150-blinkon175

syntax enable


highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline
highlight OperatorSandwichChange guifg='#edc41f' gui=underline
highlight OperatorSandwichAdd guibg='#b1fa87' gui=none
highlight OperatorSandwichDelete guibg='#cf5963' gui=none


" 防止tmux下vim的背景色显示异常
if &term =~ '256color'
" http://sunaku.github.io/vim-256color-bce.html
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
    set t_ut=
endif


" Todo
" 设置可以高亮的关键字
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, etc.
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(todo\|FIXME\|CHANGED\|DONE\|Todo\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
endif


" 不加bold时，背景前景会 对调
hi StatusLine     gui=bold guibg=#a4e4e4 guifg=#004040
hi StatusLineNC   gui=bold guibg=#e0f0f0 guifg=#0099a0


" 每行超过 n 个字的时候 , vim 自动加上换行符
set textwidth=100




" hi User0 guifg=#ffffff  guibg=#094afe
hi User0 guifg=#000000  guibg=#000a99
" hi User1 guifg=#ffdad8  guibg=#880c0e
" hi User2 guifg=#000000  guibg=#F4905C
" hi User3 guifg=#292b00  guibg=#f4f597
" hi User4 guifg=#112605  guibg=#aefe7B
" hi User5 guifg=#051d00  guibg=#7dcc7d
" hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
" hi User8 guifg=#ffffff  guibg=#5b7fbb
" hi User9 guifg=#ffffff  guibg=#810085

source ~/dotF/cfg/nvim/tab_status_lines.vim
    " 或者叫tabline? tab statusline tab栏 tab status
