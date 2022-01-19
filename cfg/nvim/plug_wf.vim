
func VimPlugConds(arg1, ...)
    " Lazy loading, my preferred way, as you can have both [避免被PlugClean删除没启动的插件]
    " https://github.com/junegunn/vim-plug/wiki/tips
    " leo改过

        " a: 表示argument
        " You must prefix a parameter name with "a:" (argument).
            " a:0  等于 len(a:000)),
            " a:1 first unnamed parameters, and so on.  `a:1` is the same as "a:000[0]".
        " A function cannot change a parameter

                " To avoid an error for an invalid index use the get() function
                " get(list, idx, default)
        let leo_opts = get(a:000, 0, {})  "  a:000 (list of all parameters), 获得该list的第一个元素
        " Borrowed from the C language is the conditional expression:
        " a ? b : c
        " If "a" evaluates to true, "b" is used
        let out = (a:arg1 ? leo_opts : extend(leo_opts, { 'on': [], 'for': [] }))  " 括号不能换行
        " an empty `on` or `for` option : plugin is registered but not loaded by default depending on the condition.
        return  out
    endfunc

Plug 'junegunn/vim-plug'
    " 为了能用:help plug-options

Plug 'voldikss/vim-translator'
    " todo mobaxterm 2080ti上不行

    " <Leader>t 翻译光标下的文本，在命令行回显
    nnoremap  <Leader>a <Plug>Translate
    vnoremap <silent> <Leader>a <Plug>TranslateV
    " h被占了
    " <Leader>h 翻译光标下的文本，在窗口中显示   h：here
    nnoremap <silent> <Leader>a <Plug>TranslateW
    vnoremap <silent> <Leader>a <Plug>TranslateWV
    " Leader h被 set hlsearch！占用了

Plug 'sheerun/vim-polyglot'
Plug 'andymass/vim-matchup'
Plug 'junegunn/vim-easy-align'



" 装了没啥变化，neovim本身就可以实现：多个窗口编辑同一个文件时，只要一个窗口保存了，
" 跳到另一个窗口，会看到变化
    " Plug 'gioele/vim-autoswap'
    " set title
    " " the default titlestring will work just fine
    " set titlestring=
    " let g:autoswap_detect_tmux = 1


if !exists('g:vscode')
    Plug 'plasticboy/vim-markdown'
    Plug 'preservim/nerdtree'
    " Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }  " 会报错
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
    Plug 'jonathanfilip/vim-lucius'   " colorscheme lucius
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'easymotion/vim-easymotion'
else
    " Plug 'asvetliakov/vim-easymotion', VimPlugConds(exists('g:vscode'), { 'as': 'leo-jump' })  " as的名字随便起，
        " 这样可能更容易理解，没那么绕:
        " Plug 'easymotion/vim-easymotion',  has('g:vscode') ? { as': 'ori-easymotion', 'on': [] } : {}
        " Plug 'asvetliakov/vim-easymotion', has('g:vscode') ? {} : { 'on': [] }
            " 【an empty `on` or `for` option :
            " plugin is registered but not loaded by default depending on the condition.】
endif

" 要编译python+，难搞 放弃
" 允许多人同时编辑一个文件。避免多处打开同一个文件
" Plug 'FredKSchott/CoVim', VimPlugConds(!exists('g:vscode'))

" ga :  记作 get alignment,  本来是get ascii
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" wf_align
    " \|是竖线的escape   dict里面不能放注释？ shell的换行也是，不像python
    " 空行分开的前面几个,是我自定义的
    " 小心对齐后 字符串里多出来的空格
    let g:easy_align_delimiters = {
        \                          'r': { 'pattern': "whatever_wf_want" },
        \
        \                          '?': { 'pattern': '?' },
        \                          ':': { 'pattern': ":" },
        \                          '\': { 'pattern': '\' },
        \
        \                          '>': { 'pattern': '>>\|=>\|>' },
        \                          '/': {
        \                                 'pattern'         : '//\+\|/\*\|\*/',
        \                                 'delimiter_align' : 'l',
        \                                 'ignore_groups'   : ['!Comment']
        \                               },
        \                          ']': {
        \                                 'pattern'       : '[[\]]',
        \                                 'left_margin'   : 0,
        \                                 'right_margin'  : 0,
        \                                 'stick_to_left' : 0
        \                               },
        \                          ')': {
        \                                 'pattern'       : '[()]',
        \                                 'left_margin'   : 0,
        \                                 'right_margin'  : 0,
        \                                 'stick_to_left' : 0
        \                            },
        \                          'd': {
        \                                 'pattern'      : ' \(\S\+\s*[;=]\)\@=',
        \                                 'left_margin'  : 0,
        \                                 'right_margin' : 0
        \                               }
        \                          }

" [[==============================easymotion 配置=====================begin

" Plug 'asvetliakov/vim-easymotion'   " vscode定制的easymotion
" Plug 'easymotion/vim-easymotion'    " 只用裸nvim下的easymotion  千万别这么干。会把正在编辑的文件全搞乱


" map <Leader> <Plug>(easymotion-prefix)
" 默认:
map <Leader><Leader> <Plug>(easymotion-prefix)

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " 敲小写，能匹配大写。反之不然

" Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" todo  debug buggy 出了问题来这里
"s for search
" 用了vim-sandwich的默认keymapping，sa代表sandwich add.  sd 代表sandwich delete
" 干脆用大写的S算了，避免冲突
nmap S <Plug>(easymotion-f)
" 用nnoremap不行


" Need one more keystroke
nmap f <Plug>(easymotion-f2)

" 会抽风颤抖
" nmap f <Plug>(easymotion-f) "f{char}
" map  <Leader>f <Plug>(easymotion-bd-f) " <Leader>f{char} to move to {char}
"" umap后，变回默然的功能
" unmap f

" 会显示高亮字母后，光标到下一行
" nmap S <Plug>(easymotion-f2) " {char}{char} 怎样可以上下文都搜索？现在只能搜下文
" map  <Leader>w <Plug>(easymotion-w) " Move to word    " buftype option is set??
" ================================easymotion 配置=====================]]

Plug 'kurkale6ka/vim-pairs'   " 和sandwich“互补”
Plug 'machakann/vim-sandwich'
" 别再试同类(前浪)
"  Plug 'tpope/vim-surround'
"  Plug 'kana/vim-textobj-user'
"  Plug 'sgur/vim-textobj-parameter'



Plug 'scrooloose/nerdcommenter'



Plug  'Yggdroot/LeaderF'
" >>>---------------------------------------------------------------------LeaderF
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1


" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

" let g:Lf_ShortcutF = "<leader>o"
" 和zsh下按ctrl f 作用一致
let g:Lf_ShortcutF = "<c-f>"  " 要想快点弹出窗口，按下f后，马上输出字符
" mru: most recently used file
" C-u: 删掉cmdline的字符。主要对visual mode有用？很多插件都这么设
    nnoremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
" search a line in current buffer.  " 有点vscode下的感觉
    nnoremap <leader>/ :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
" <cword> is replaced with the word under the cursor (like |star|)
    " nnoremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
    " 删掉了叹号
    "  LeaderfFunction! 叹号版本直接打开 normal 模式，并且定位到对应位置
    nnoremap <C-B> :<C-U><C-R>=printf("Leaderf rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
    " 不确定是否靠谱  " 代替在zsh中用rg
    nnoremap <leader>f :<C-U><C-R>=printf("Leaderf rg -g '!*.zsh_history' -g '!*.lesshst' -g '!/data1/weifeng_liu/.large_trash' ")<CR><CR>
    " 这个不起作用，不能ctrl+shift？
    " nnoremap <C-S-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR><CR>
    " nnoremap <C-S-F> :<C-U><C-R>=printf("Leaderf! rg -e ")<CR><CR>

" search visually selected text literally
" xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
" noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
" noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
" noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" ---------------------------------------------------------------------<<<LeaderF

Plug 'sisrfeng/toggle-bool'

" leaderf里有这个keybind，我这里覆盖掉
noremap <leader>b :ToggleBool<CR>

Plug 'mbbill/undotree'
" On top of all language packs from vim repository. syntax支持
Plug 'sheerun/vim-polyglot'
