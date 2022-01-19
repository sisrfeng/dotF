" abbrev >_>_>==========================================================begin
call plug#begin(stdpath('data') . '/plugged')
    Plug 'plasticboy/vim-markdown'

    " Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }  " 会报错
    Plug 'preservim/nerdtree'
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

call plug#end()

" abbrev 和map的区别，就像ahk里 hotkey和hotstring
" 触发： space, Escape, or Enter.
abbrev nore noremap
inoreabbrev ali alias
inoreabbrev mpa map
inoreabbrev ali alias
inoreabbrev al alias
inoreabbrev df ~/dotF/
inoreabbrev HO $HOME/


" cnoremap s/ s/\v
" vscode里，用了camp时，必须在光标后有字符才能正常map

" <expr> 指明了right hand side是表达式
" cnoremap    <expr> bd    getcmdtype() == ":" && getcmdline() == 'bd'   ? 'tabedit ~/.zshrc' : 'tabedit'
" bd 本来是buffer delete的意思。现在用bde代替吧



cnoreabbrev <expr> zbk   getcmdtype() == ":" && getcmdline() == 'zbk'          ? 'tabedit ~/dotF/bindkey_wf.zsh'     :   'zbk'
cnoreabbrev <expr> pi    getcmdtype() == ":" && getcmdline() == 'pi'           ? 'PlugInstall'                       :   'pi'
cnoreabbrev <expr> ctr   getcmdtype() == ":" && getcmdline() == 'tab help ctr' ? 'CTRL'                              :   'ctr'
cnoreabbrev <expr> bd    getcmdtype() == ":" && getcmdline() == 'bd'           ? 'tabedit ~/.zshrc'                  :   'bd'
cnoreabbrev <expr> e     getcmdtype() == ":" && getcmdline() == 'e'            ? 'tabedit'                           :   'e'
cnoreabbrev <expr> et    getcmdtype() == ":" && getcmdline() == 'et'           ? 'tabedit ~/d/tmp.py'                :   'et'
cnoreabbrev <expr> tc    getcmdtype() == ":" && getcmdline() == 'tc'           ? 'tabedit ~/dotF/cfg/tmux/tmux.conf' :   'tc'
cnoreabbrev <expr> in    getcmdtype() == ":" && getcmdline() == 'in'           ? 'tabedit ~/dotF/cfg/nvim/init.vim'  :   'in'
cnoreabbrev <expr> s     getcmdtype() == ":" && getcmdline() == 's'            ? 'tabedit ~/dotF/rc.zsh'             :   's'
cnoreabbrev <expr> al    getcmdtype() == ":" && getcmdline() == 'al'           ? 'tabedit ~/dotF/alias.zsh'          :   'al'
cnoreabbrev <expr> map   getcmdtype() == ":" && getcmdline() == 'map'          ? 'verbose map'                       :   'map'
cnoreabbrev <expr> imap  getcmdtype() == ":" && getcmdline() == 'imap'         ? 'verbose imap'                      :   'imap'
cnoreabbrev <expr> cmap  getcmdtype() == ":" && getcmdline() == 'cmap'         ? 'verbose cmap'                      :   'cmap'
cnoreabbrev <expr> cm    getcmdtype() == ":" && getcmdline() == 'cm'           ? 'tab help'                          :   'cm'
cnoreabbrev <expr> h     getcmdtype() == ":" && getcmdline() == 'h'            ? 'tab help'                          :   'h'
cnoreabbrev <expr> cfg   getcmdtype() == ":" && getcmdline() == 'cfg'          ? 'cd ~/dotF/cfg'                     :   'cfg'
cnoreabbrev <expr> mdf   getcmdtype() == ":" && getcmdline() == 'mdf'          ? 'cd ~/dotF/'                        :   'mdf'
cnoreabbrev <expr> dot   getcmdtype() == ":" && getcmdline() == 'dot'          ? 'cd ~/dotF/'                        :   'dot'
cnoreabbrev <expr> ~/    getcmdtype() == ":" && getcmdline() == '~/'           ? 'cd ~/'                             :   '~/'



cnoremap <C-a> <Home>
cnoremap <C-e> <End>



nnoremap ss :wq<CR>
vnoremap ss :<C-U>wq<CR>
nnoremap qq :q!<CR>
vnoremap qq :<C-U>q!<CR>
" nnoremap q :wq<CR>  按一次q要等一会才退出， 不如连续按2次快
" inoremap qq <ESC>:wq<CR>  别这么干，容易在编辑时敲错

noremap j gj
noremap k gk

" map vs map! : map控制“字母不是用于输入”的几个mode，map！控制“字母 是用于输入的字符串的”mode
noremap H g^
" nnoremap H g0
noremap 0 g0
noremap <Home> g0
noremap L g$
noremap <End> g$

onoremap <silent> j gj
onoremap <silent> k gk
" nnoremap dd g^dg$i<BS><Esc>
" nnoremap yy g^yg$
" nnoremap cc g^cg$
nnoremap A g$a
nnoremap I g^i

nnoremap gm g$
" nnoremap M

nnoremap <c-\> <c-w>v
nnoremap <c-w>-  <c-w>s



if &diff
    " 反应变慢，不好
    " map ] ]c
    " map [ [c
endif
" map 默认是recursive的


" >_>_>===================================================================begin
" echo '没在用 vscode-neovim, 纯 nvim'

" <C-]>只能在本文件内跳转
nnoremap gd g<C-]>
" nnoremap gd :KiteGotoDefinition<CR>

set  number relativenumber
nnoremap <Leader>n :call HideNumber()<CR>
func HideNumber()
    if(&relativenumber == &number)
        " 叹号或者加inv：表示toggle
        set invrelativenumber invnumber
    elseif(&number)
        set invnumber
    else
        set relativenumber!
    endif

    " :se[t] {option}?  Show value of {option}.
    " set number?
endfunc

set wrap    " vscode里, 要在setting.json设置warp



" vscode上有插件自动处理，不用加这些:
set expandtab " 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set tabstop=4 " 设置Tab键等同的空格数
set shiftwidth=4 " 每一次缩进对应的空格数
set smarttab " insert tabs on the start of a line according to shiftwidth
set shiftround " 用shiftwidth的整数倍， when indenting with '<' and '>'
set softtabstop=4 " 按退格键时可以一次删掉 4 个空格
" 如果要仅对python有效：  autocmd Filetype python set 上面那堆

" `各种indent方法`
    " 只是对c语言家族而言？
    " 'autoindent'  uses the indent from the previous line.
    " 'smartindent' is like 'autoindent' but also recognizes some C syntax to
    "                 increase/reduce the indent where appropriate.
    " 'cindent' Works more cleverly than the other two and is configurable to
    "             different indenting styles.
    " 'indentexpr'  The most flexible of all: Evaluates an expression to compute
    "       the indent of a line.  When non-empty this method overrides
    "       the other ones.  See |indent-expression|.
set cindent
" 考虑用谷歌的规范？
" https://github.com/google/styleguide/blob/gh-pages/google_python_style.vim
" set indentexpr=GetGooglePythonIndent(v:lnum)
"
" ==============================缩进==============================]]


" vscode里不行
" nnoremap zz :wq<C-R>
" inoremap zz <ESC>:wq<CR>
" cnoremap q1 q!
" Quickly close the current window
" nnoremap <leader>q :q<CR>
" Quickly save the current file
" nnoremap <leader>w :w<CR>

" 使用方向键切换buffer 。 vscode的map，别用command mode ?
"end=====================================================================<_<_<
"
"

" 已经设置了 let g:NERDCreateDefaultMappings = 0  " 之前设为1，导致vscode用不了nerdcommenter?
nnoremap ce A<space><space><Esc>o/<Esc><Esc>:call nerdcommenter#Comment("n", "Comment")<CR>kJA<BS>
" 有缩进时，有时会把开头的注释符号删掉，别完美主义吧



" >_>_>coc补全==================================================================begin

" 在前面的基础上，加上c
set shortmess+=c  " Don't pass messages to |ins-completion-menu|.

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif


" pumvisible(): Returns non-zero when the popup menu is visible
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()



" 这是干啥的
func! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunc

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" coc补全=====================================================================<_<_<



" echom '(*_* no_vscode.vim 导入完成  *_*)'


" Note: When this option is on some plugins may not work.
" 要是放到vscode里会报错:
autocmd VimEnter * set autochdir
" vscode里, 可以手动敲 :lcd
" echom 'no_vscode.vim执行完了'
