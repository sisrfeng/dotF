Plug 'junegunn/vim-plug'
    " 为了能用:help plug-options

Plug 'kana/vim-fakeclip'
Plug 'voldikss/vim-translator'

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
Plug 'andymass/vim-matchup'
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


set grepprg=r
    " 在alias里定义了r
    " set grepprg=grep\ -nH

" 和leaderF比, ctrlp的star数更多. 但比较老, 但被skywind吐槽过. 貌似不能search file by content
Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_match_window = 'bottom,order:btt,min:80,max:80,results:10'
    let g:ctrlp_switch_buffer = 'ET'

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

        " 想改键位/map      可以参考:
        " https://github.com/Yggdroot/LeaderF/issues/123
        " 让esc和vim其他情况下一致. 但tab就废掉了
        let g:Lf_CommandMap = {'<tab>':[ '<ESC>' ]}
                " let g:Lf_NormalMap = {
                "     \ "_":   [
                "     \            ["<ESC>", ':exec g:Lf_py "fileExplManager.input()"<CR>'],
                "     \            ["<tab>", ':exec g:Lf_py "fileExplManager.input()"<CR>'],
                "     \        ],
                "     \}

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

Plug 'mbbill/undotree'
" On top of all language packs from vim repository. syntax支持
Plug 'sheerun/vim-polyglot'



