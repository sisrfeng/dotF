" todo:
" nvr :  避免:terminal时 嵌套nvim
" gonvim:  gui, 且能替代nvr, 貌似比目前的官方qt版gui更受欢迎:  https://github.com/equalsraf/neovim-qt/wiki
"

" 插件源码不放进dotF, 避免用submodule等复杂命令.
" 如何应对内网, 离线安装? 到时再说

func! VimPlugConds(arg1, ...)
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

" todo :  试一下这个
" Plug 'kana/vim-fakeclip'
Plug 'voldikss/vim-translator'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

    " 翻译光标下的文本，在命令行回显
    nnoremap  gdd <Plug>Translate
    vnoremap <silent> <Leader>a <Plug>TranslateV
    " h被占了
    " <Leader>h 翻译光标下的文本，在窗口中显示   h：here
    " nnoremap <silent> <Leader>a <Plug>TranslateW
    " vnoremap <silent> <Leader>a <Plug>TranslateWV
    " Leader h被 set hlsearch！占用了
    "
    let g:translator_target_lang=['youdao']
    let g:translator_window_type='preview'

    " todo: 换用:
    " https://github.com/echuraev/translate-shell.vim


Plug 'sheerun/vim-polyglot'
    " A collection of language packs for Vim.
    " 其中用了: " https://github.com/ericpruitt/tmux.vim
    " 有时有些小bug也正常, 毕竟不能所有环节都及时更新
Plug 'andymass/vim-matchup'
    " match-up can be used as a drop-in replacement for the classic plugin matchit.vim.
    " 看官网的Options部分, 貌似和sandwich有些重复
    " let g:matchup_matchparen_offscreen = {'method': 'popup'}  " 可能挡住底下一行代码
    let g:matchup_matchparen_offscreen = {'method': 'status'}
Plug 'junegunn/vim-easy-align'
Plug 'lifepillar/vim-solarized8'

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
    Plug 'APZelos/blamer.nvim'
    " Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }  " 会报错
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
        " move (rename) / delete file, 代替netrw
        nnoremap <c-t> :NERDTreeFind<CR>
    Plug 'jonathanfilip/vim-lucius'   " colorscheme lucius
    " 把coc装的东西从我的dotfile改到其他位置, 不然弄脏目录
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
        " :CocInstall coc-vimlsp
        " 好用!  补全时的LS表示language server在提供支持

        " 没有这行 可能导致coc-pyright无法使用
        autocmd FileType python let b:coc_root_patterns = ['.git', 'pyrightconfig.json']
            " user's home directory would never considered as workspace folder.
endif
Plug 'easymotion/vim-easymotion',  has('g:vscode') ? { 'as': 'easymotion_ori', 'on': [] } : {'as': 'easymotion_ori'}
Plug 'asvetliakov/vim-easymotion', has('g:vscode') ? {'as': 'easymotion_vsc'}             : { 'as': 'easymotion_vsc', 'on': [] }
                                                                " 【an empty `on` or `for` option :
                                                                "    not loaded by default depending on the condition.】
                                                                "    but plugin is registered  防止PlugClean清掉
    " 类似:
            " todo
            " https://github.com/pechorin/any-jump.vim

            "  Plug 'tpope/vim-repeat'
            "  Plug 'kkoomen/vim-doge'
            "  Plug 'mattn/emmet-vim'
            "  Plug 'junegunn/vim-easy-align'
            "  Plug 'chaoren/vim-wordmotion'

                " vim眼中的一个word
                " 我的笔记 https://github.com/vim/vim/issues/576
                " https://vi.stackexchange.com/a/36657/38936

                    " 先了解几种常见character classes
                        " Those also work for multibyte characters:
                                " \k	keyword character (see 'iskeyword' option)
                                " \K	like "\k", but excluding digits

                                " \w	word character:			[0-9A-Za-z_]
                                " \W	non-word character:		[^0-9A-Za-z_]	 (搜索时  可以匹配中文等non ascii字符)

                    " word/WORD
                    "         consist of a sequence of
                    "                               1.  letters, digits and underscores,  【word的定义can be changed with the 'iskeyword' option.
                    "                                                                        比如set iskeyword+=-后, 连字符就成为类别1的一员】
                    "                               2.  other non-blank characters, (包括non-word character a中文单词一a a中文单词一a  这也是:中文单词一)
                    "                                   (类别1的character 被中文等类别2的character隔开时, 中文不属于这个word, 但属于这个WORD
                    "                                   类别2被类别1隔开, 同样道理)
                    "                               word是狭义的单词, WORD是广义的单词
                    "         separated with:
                    "                       white space  (spaces,  tabs, <EOL>).
                    "


                        " An empty line  is also considered to be a word/WORD
                        "
                        " A sequence of folded lines is counted for:   one word of a single character.
                        "
                        " todo:
                                " "w" and "W", "e" and "E" move to the start/end of the first word or WORD after a range of folded lines.
                                "
                                " "b" and "B" move to the start of the first word or  WORD before the fold.



                    " 'iskeyword' 'isk'	string (default: @,48-57,_,192-255 )  128到255是extended  ascii, 大部分是西文字母, 我们用不上
                    "                                      对应数字0到9
                        "    local to buffer

                        "    会影响命令 :K
                                    " [count]K
                                    "     Runs the program given by 'keywordprg' to lookup the
                                    "     |word| (defined by 'iskeyword') under or right of the
                                    "     cursor.
                                    "
                                    "     我现在:    keywordprg=:help

                        "     Keywords are used in searching and recognizing with many commands:
                        "           "w",
                        "           "*",
                        "           "[i",
                        "           "\k" in a |pattern|.(搜\k能匹配中文)
                        "
                        "     Q:没明白 keyword如何定义word,  word不就是由word character [0-9A-Za-z] 组成的吗?
                        "     A: 非也, set iskeyword+=- 以后, peco-find就是一个word,  但连字符不属于word character
                        "
                        "
                        "     See  'isfname' for a description of the format of this option.
                        "
                                    " The format of this option is a list of parts, separated with commas.
                                    " Each part can be a single character number or a range.  A range is two
                                    " character numbers with '-' in between.  A character number can be a
                                    " decimal number between 0 and 255 or the ASCII character itself (does
                                    " not work for digits).  Example:
                                    "     "_,-,128-140,#-43"	(include '_' and '-' and the range
                                    "                 128 to 140 and '#' to 43)
                        "     如果加了'@':
                        "         characters above 255将会:
                            "        check (其实是想表达fall back to ?) the "word"  character class
                            "                   (当作"word"  character ?)
                            "        也就是:any character  that is not white space or punctuation, )
                            "     想把中文放进'iskeyword? 暂时不行: https://github.com/vim/vim/issues/576
                            "

                        "     This option also influences syntax highlighting,
                        "            unless the syntax  uses |:syn-iskeyword|.

                                    " It is recommended when writing syntax files, to use this command to
                                    " set the correct value for the specific syntax language and not change
                                    " the 'iskeyword' option.
                                    "
                                    "

" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'




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
        \                          'f': { 'pattern': "format" },
        \
        \                          '?': { 'pattern': '?' },
        \                          ':': { 'pattern': ":" },
        \                          '~': { 'pattern': '\~/__危险_万一多出空格_把HOME目录删了就麻烦了_别这么设' },
        \                          '\': { 'pattern': '\\$' },
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

Plug 'easymotion/vim-easymotion', VimPlugConds(!exists('g:vscode'))
Plug 'asvetliakov/vim-easymotion', VimPlugConds(exists('g:vscode'), { 'as': 'leo-jump' })  " as的名字随便起，

" 这样可能更容易理解，没那么绕: 【an empty `on` or `for` option : plugin is registered but not loaded by default depending on the condition.】
" Plug 'easymotion/vim-easymotion',  has('g:vscode') ? { as': 'ori-easymotion', 'on': [] } : {}
" Plug 'asvetliakov/vim-easymotion', has('g:vscode') ? {} : { 'on': [] }

" map <Leader> <Plug>(easymotion-prefix)
" 默认:
map <Leader><Leader> <Plug>(easymotion-prefix)

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " 敲小写，能匹配大写。反之不然

" Line motions
map <Leader>j <Plug>(easymotion-j)
    " 用noremap不行, 不过后面是<Plug> 应该不会出问题
map <Leader>k <Plug>(easymotion-k)

" todo  debug buggy 出了问题来这里
"s for search
" 用了vim-sandwich的默认keymapping，sa代表sandwich add.  sd 代表sandwich delete
" 所以敲s后 要等一会
nmap s <Plug>(easymotion-f)
nmap S 0<Plug>(easymotion-f)

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


" Plug 'https://github.com/airblade/vim-rooter'
    " 如果这个插件有问题, 就试下面的( 但leaderF似乎没了vim-rooter就不能自动跳转pwd)
    " todo: leaderF每个命令前都要敲一下 :pwd
        " autocmd VimEnter * set autochdir
            " Note: When this option is on some plugins may not work.
            " 在vscode里会报错, 放到no_vscode.vim
        " vscode里: 可以手动敲 :lcd
                    " 或者这个?:    autocmd BufEnter * silent! lcd %:p:h
autocmd VimEnter * set autochdir
" 这又可以了,反倒是rooter不行


" set grepprg=r
    " 在alias里定义了r
    " set grepprg=grep\ -nH

" " 和leaderF比, ctrlp的star数更多. 但比较老, 但被skywind吐槽过. 貌似不能search file by content
" Plug 'ctrlpvim/ctrlp.vim'
"     let g:ctrlp_match_window = 'bottom,order:btt,min:80,max:80,results:10'
"     let g:ctrlp_switch_buffer = 'ET'

Plug  'Yggdroot/LeaderF'
        " don't show the help in normal mode
        let g:Lf_HideHelp = 1
        let g:Lf_UseCache = 1
        let g:Lf_UseVersionControlTool = 0
        let g:Lf_IgnoreCurrentBufferName = 0

        " let g:Lf_WindowPosition = 'fullScreen'
        " popup mode
        let g:Lf_WindowPosition = 'popup'
        let g:Lf_PreviewInPopup = 1
        let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
        let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

        " 格式: '旧键位' : ['新键位1', 新键位2' ]
            let g:Lf_CommandMap = {'<tab>':[ '<ESC>' ],
                                \'<c-t>':[ '<cr>'  ]}   "insert模式下, enter在new tab打开

            " 不行...还是要按t才能在new tab是打开
            let g:Lf_NormalMap = {
                \ "_":   [
                \            ['<cr>', 't'],
                \        ],
                \}

        let g:Lf_RgConfig = [
            \ "--max-columns=150",
            \ "--type-add web:*.{html,css,js}*",
            \ "--glob=!git/*",
            \ "--glob=!**/coc/extensions/node_modules*",
            \ "--hidden"
            \ ]

        " 和zsh下按ctrl f 作用一致
        let g:Lf_ShortcutF = "<c-f>"  " 要想快点弹出窗口，按下f后，马上输出字符
        " mru: most recently used file
        " C-u: 删掉cmdline的字符。主要对visual mode有用？很多插件都这么设
            " m: most recenly
            nnoremap <leader>m :<C-U>tab   <C-R>=printf("Leaderf! mru %s", "")<CR><CR>
        " search a line in current buffer.  " 有点vscode下的感觉
            nnoremap <leader>/ :<C-U>tab   <C-R>=printf("Leaderf line %s", "")<CR><CR>
        " <cword> is replaced with the word under the cursor (like |star|)
            " nnoremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
            " 删掉了叹号
            "  LeaderfFunction! 叹号版本直接打开 normal 模式，并且定位到对应位置
            nnoremap <C-B>     :<C-U>tab   <C-R>=printf("Leaderf rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
            " 不确定是否靠谱  " 代替在zsh中用rg
            nnoremap <leader>f :<C-U>tab   <C-R>=printf("Leaderf rg -g '!*.zsh_history' -g '!*.lesshst' -g '!/data1/weifeng_liu/.large_trash' ")<CR><CR>
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

" 貌似比gundo和mundo好
Plug 'mbbill/undotree'
    nnoremap <F4> :UndotreeToggle<CR>
    let g:undotree_SetFocusWhenToggle = 1
    if has('persistent_undo')
        let path_undo = expand('$XDG_CACHE_HOME/.undo_nvim')
        if !isdirectory(path_undo)
            call mkdir(path_undo, "p", 0700) " create the directory and any parent directories
        endif

        let &undodir=path_undo
        set undofile
    endif

    " 具体设置:
        if !exists('g:undotree_WindowLayout')
            let g:undotree_WindowLayout = 4
        endif

        " " e.g. using 'd' instead of 'days' to save some space.
        if !exists('g:undotree_ShortIndicators')
            let g:undotree_ShortIndicators = 1
        endif

        " undotree window width
        if !exists('g:undotree_SplitWidth')
            if g:undotree_ShortIndicators == 1
                let g:undotree_SplitWidth = 24
            else
                let g:undotree_SplitWidth = 30
            endif
        endif

        " diff window height
        if !exists('g:undotree_DiffpanelHeight')
            let g:undotree_DiffpanelHeight = 10
        endif

        " auto open diff window
        if !exists('g:undotree_DiffAutoOpen')
            let g:undotree_DiffAutoOpen = 1
        endif

        " if set, let undotree window get focus after being opened, otherwise
        " focus will stay in current window.
        if !exists('g:undotree_SetFocusWhenToggle')
            let g:undotree_SetFocusWhenToggle = 1
        endif

        " tree node shape.
        if !exists('g:undotree_TreeNodeShape')
            let g:undotree_TreeNodeShape = ' '
        endif

        " tree vertical shape.
        if !exists('g:undotree_TreeVertShape')
            let g:undotree_TreeVertShape = '|'
        endif

        if !exists('g:undotree_DiffCommand')
            let g:undotree_DiffCommand = "diff"
        endif

        " relative timestamp
        if !exists('g:undotree_RelativeTimestamp')
            let g:undotree_RelativeTimestamp = 1
        endif

        " Highlight changed text
        if !exists('g:undotree_HighlightChangedText')
            let g:undotree_HighlightChangedText = 1
        endif

        " Highlight changed text using signs in the gutter
        if !exists('g:undotree_HighlightChangedWithSign')
            let g:undotree_HighlightChangedWithSign = 1
        endif

        " Highlight linked syntax type.
        " You may chose your favorite through ":hi" command
        if !exists('g:undotree_HighlightSyntaxAdd')
            let g:undotree_HighlightSyntaxAdd = "DiffAdd"
        endif
        if !exists('g:undotree_HighlightSyntaxChange')
            let g:undotree_HighlightSyntaxChange = "DiffChange"
        endif
        if !exists('g:undotree_HighlightSyntaxDel')
            let g:undotree_HighlightSyntaxDel = "DiffDelete"
        endif

        " Deprecates the old style configuration.
        if exists('g:undotree_SplitLocation')
            echo "g:undotree_SplitLocation is deprecated,
                        \ please use g:undotree_WindowLayout instead."
        endif

        " Show help line
        if !exists('g:undotree_HelpLine')
            let g:undotree_HelpLine = 0
        endif

        " Show cursorline
        if !exists('g:undotree_CursorLine')
            let g:undotree_CursorLine = 1
        endif



" On top of all language packs from vim repository. syntax支持
Plug 'sheerun/vim-polyglot'

Plug 'brooth/far.vim'
Plug 'AndrewRadev/linediff.vim'
Plug 'https://github.com/rickhowe/diffchar.vim'

" 准备抛弃tmux
    " Plug 'akinsho/toggleterm.nvim'
    Plug 'https://github.com/mhinz/neovim-remote'

    Plug 'nikvdp/neomux'  " 会导致terminal退出后, 多出一个split窗口
        let g:neomux_win_num_status='窗:%{WindowNumber()}'

    Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
    let g:sayonara_confirm_quit=1  " 没有buffer就退出, 不用确认,
                                " 智能处理:wq :bd等
