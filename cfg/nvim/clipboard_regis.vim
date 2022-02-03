" 我的飞书笔记:https://cmb-d3-ocr.feishu.cn/docs/doccnSbue41vpDkdPAtYDWrxaNc#
" 和系统粘贴板打通(但隔着ssh, 到不了本地), 有了tmux_好像不用了
    noremap <Leader>y "*y
    noremap <Leader>Y "+y
    noremap <Leader>p "*p
    noremap <Leader>P "+p

    " todo:  https://vi.stackexchange.com/questions/7449/how-can-i-use-tmux-for-copying-if-i-cant-access-the-system-clipboard
         nnoremap <silent> yy yy:call system('tmux set-buffer -b vim ' . shellescape(@"))<CR>
         nnoremap <silent> p :let @" = system('tmux show-buffer -b vim')<cr>p$x







" The presence of a working `clipboard tool`    implicitly enables the '+' and '*' registers.
  " Nvim looks for these clipboard tools, in order of priority:

            "  |g:clipboard|  we can custom xclip by set g:clipboard
            "  xclip (if $DISPLAY is set)
            "  etc.....




        if hostname() == 'redmi14-leo'
        " if has('win32')
            let g:clipboard = {
                            \   'name': 'wf-win32yank-wsl',
                            \   'copy': {
                            \      '+': 'echo "I am 加号寄存器"',
                            \      '*': '/mnt/d/win32yank.exe -i --crlf',
                            \    },
                            \   'paste': {
                            \      '+': '/mnt/d/win32yank.exe -o --lf',
                            \      '*': '/mnt/d/win32yank.exe -o --lf',
                            \   },
                            \   'cache_enabled': 0,
                            \ }
            set clipboard=unnamed
        else
        " todo: 参考:https://searchcode.com/file/189000618/vim/cfg/features/clipboard.vim/

            " To configure a custom clipboard tool,
            let g:clipboard = {
                \   'name': 'myClipboard',
                \   'copy': {
                \      '+': '/home/linuxbrew/.linuxbrew/bin/xclip -selection clipboard -silent -loop 2',
                \      '*': ['tmux', 'load-buffer', '-'],
                \    },
                \   'paste': {
                \      '+': '/home/linuxbrew/.linuxbrew/bin/xclip -selection clipboard -out',
                \      '*': ['tmux', 'save-buffer', '-'],
                \   },
                \   'cache_enabled': 1,
                \ }

            " primary对应鼠标中键, 都用鼠标了, 那就别占了星号寄存器
                " help里的写法: ['tmux', 'load-buffer', '-'],
                " 看到Stack Overflow有人的写法 (整个string)  'win32yank.exe -o --lf'

            " let g:clipboard = {
            "     \   'name': 'myClipboard',
            "     \   'copy': {
            "     \      '+': ['tmux', 'load-buffer', '-'],
            "     \      '*': ['tmux', 'load-buffer', '-'],器

            " let g:clipboard = {
            "     \   'name': 'myClipboard',
            "     \   'copy': {
            "     \      '+': ['tmux', 'load-buffer', '-'],
            "     \      '*': ['tmux', 'load-buffer', '-'],

            "     \    },
            "     \   'paste': {
            "     \      '+': ['tmux', 'save-buffer', '-'],
            "     \      '*': ['tmux', 'save-buffer', '-'],
            "     \   },
            "     \   'cache_enabled': 1,
            "     \ }
            " let g:clipboard = {
            " \ 'name': 'wf_xclip',
            " \ 'copy': {
            " \   '+': ['xclip', '-selection', 'clipboard', '-silent', '-loop', '2'],
            " \   '*': ['xclip', '-selection', 'primary', '-silent', '-loop', '2'],
            " \  },
            " \ 'paste': {
            " \   '+': 'xclip -selection clipboard -out',
            " \   '*': 'xclip -selection primary  -out',
            " \ },
            " \ 'cache_enabled': 1,
            " \}
            " 这样不行
            "     '*': 'echom "wf_paste" ; xclip -selection primary  -out',
            " https://stackoverflow.com/a/67229362/14972148
            " 确实会创建目录
            " let g:clipboard = {
            "                 \ 'name': 'xsel-remote',
            "                 \ 'copy': {
            "                 \   '+': 'mkdir -p /home/wf/.t/cccccccccccccccccccc加',
            "                 \   '*': 'mkdir -p /home/wf/.t/cccccccccccccccccccc星',
            "                 \  },
            "                 \ 'paste': {
            "                 \   '+': 'mkdir -p /home/wf/.t/pppppppppppppppppppppp加',
            "                 \   '*': 'mkdir -p /home/wf/.t/pppppppppppppppppppppp星',
            "                 \ },
            "                 \ 'cache_enabled': 1,
            "                 \}
            set clipboard=unnamedplus  " 看我上面定义的加号寄存器
             " set clipboard^=unnamed,unnamedplus  " 在linux, windows和mac的behavior一致
                        " ^= 表示prepend,  += 表示append  (对于string是这样)
                    " 让unnamed寄存器(") 一直point to 加号寄存器,  同时给星号寄存器复制一份(这不就浪费了一个寄存器?
                    " 现在又没有这个了缺点: 导致vim内粘贴 跟远程传到本地 似的, 很慢:

            " xming开了也没用, 必须开moba 且在moba也连到远程
            " 之前的笔记:
                " echo 'vim能和tmux打通了. 有时报错 can not open display啥的. 有时又正常, 哪怕在用windows terminal, 且没开xming'
        endif




" v:register	The name of the register in effect for the current normal mode command
    " v:register 取值情况:
            "  1. if 'clipboard' contains "unnamed" :
            "          echo v:register  输出* (星号)
            "  2. if 'clipboard' contains "unnamedplus":
            "          echo v:register  输出+ (加号)
            "  3. if none is supplied:
            "         echo v:register  输出" (双引号,  default register)


                    " inoremap <C-V> "+p
                " 之前为啥要这行? 不加也是粘贴
            " iunmap <c-v>
            "   加了这行,导致ctrl c不能成为i_ctrl-v

            inoremap <C-P> <Esc>pa

            " xsel:

                    " --input            -i  | read standard input into the selection
                    " --clipboard        -b  | operate on the CLIPBOARD selection
                    " --primary          -p  | operate on the PRIMARY selection (default)
                    " --secondary        -s  | operate on the SECONDARY selection

            " xclip
                    " xclip reads text from standard input or files and makes it available to
                    " other X applications for pasting as an X selection (traditionally with the middle  mouse  button).

                    " The default action is to silently  wait  in  the  background  for `X selection requests (pastes)`
                    " until another X application places data in the clipboard, at which point xclip exits silently.
                    " You can use  the -verbose option to see if and when xclip actually receives
                    " selection requests from other X applications. (TUI的貌似不算)

                            " -selection
                            "      specify which X selection to use,
                            "      options are:
                            "         "primary" to use XA_PRIMARY (default),
                            "         "secondary" for XA_SECONDARY or
                            "         "clipboard"  for XA_CLIPBOARD 这几个大写单词, 半天没搜到出处






" 之前在init.vim的内容:
    " todo: vscode中会复制到 前后空格  " a变成i估计就行了
    nnoremap vp viwp
    nnoremap vw viw
        " 想选到单词末尾, 用ve
    " 看哪个好用
        nnoremap vP Vip
        nnoremap <leader>v Vip
    " 类似于Y D C等，到行末
        nnoremap P v$<left>P
    " noremap x "_x
        " 导致xp无法使用 (专治typo)
    vnoremap p "_dP
        " paste in visual mode without updating the default register

    nnoremap p gp
        " todo:
        " You can implement a custom paste handler by redefining |vim.paste()|.
        " Example:详见wf_lua.lua
            lua require('wf_lua')
                " 说是要有个lua目录, 但我现在没建, 也可以source(lua里叫require)


    " todo: `omap`代替下面的有点重复的各种operator的map
    " omap ' i'
    " omap " vi"
    " omap ( i(
    " omap ) i)
    " omap [ i[
    " omap ] i]
    " omap { i{
    " omap } i}
    " omap } i}
    " omap ' i'



    nnoremap v" vi"
    nnoremap v( vi(
    nnoremap v) vi)
    nnoremap v[ vi[
    nnoremap v] vi]
    nnoremap v{ vi{
    nnoremap v} vi}
    nnoremap v} vi}


    nnoremap yp yyp
    nnoremap yw yiwwh
        " 复制完,跑到下一个空格, 方便粘贴. 好用吗?
    nnoremap y' yi'
    nnoremap y" yi"
    nnoremap y( yi(
    nnoremap y) yi)
    nnoremap y[ yi[
    nnoremap y] yi]
    nnoremap y{ yi{
    nnoremap y} yi}


    nnoremap cw ciw



    func! DoubleAsSingle()
        " When [!] is added, error messages will also be skipped,
        " and commands and mappings will not be aborted
        " when an error is detected.  |v:errmsg| is still set.
        let v:errmsg = ""
        silent! :s#\"\([^"]*\)\"#'\1'#g
                    " 双引号中间夹着任意 非双引号字符

            " silent:   Normal messages will 消失掉
            " When [!] is added, even when an error is detected.  commands and mappings will not be aborted
        if (v:errmsg == "")
            echo "双变单"
        endif
    endfunc

    nnoremap c' :call DoubleAsSingle()<CR>ci'
    nnoremap v' :call DoubleAsSingle()<CR>vi'
    nnoremap y' :call DoubleAsSingle()<CR>yi'
    nnoremap d' :call DoubleAsSingle()<CR>da'
    " nnoremap c' :s#\"\([^"]*\)\"#'\1'#g<CR>ci'
    " nnoremap d' :s#\"\([^"]*\)\"#'\1'#g<CR>da'
    " nnoremap v' :s#\"\([^"]*\)\"#'\1'#g<CR>vi'
    " nnoremap y' :s#\"\([^"]*\)\"#'\1'#g<CR>ya'



    nnoremap c" ci"
    nnoremap c( ci(
    nnoremap c) ci)
    nnoremap c[ ci[
    nnoremap c] ci]
    nnoremap c{ ci{
    nnoremap c} ci}

    nnoremap dw diw
    nnoremap d" da"
    " nnoremap d( da(
    " nnoremap d) da)
    " nnoremap d[ da[
    " nnoremap d] da]
    " nnoremap d{ da{
    " nnoremap d} da}



    " inoremap cb '''<Esc>Go'''<Esc><C-o>i
    " change a block  " 百分号 能自动跳到配对的符号
    " onoremap b %ib
    " nnoremap cb %cib
    " nnoremap vb %vib
    " nnoremap yb %yib

    " db:  往回删
    nnoremap dB %dab

        "默认:
            " "dib"	delete inner '(' ')' block
            " "dab"	delete a '(' ')' block
            " "dip"	delete inner paragraph
            " "dap"	delete a paragraph
            " "diB"	delete inner '{' '}' block
            " "daB"	delete a '{' '}' block

    "   "1p... is basically equivalent to "1p"2p"3p"4p.
    " You can use this to reverse-order a handful of lines: dddddddddd"1p....
    " 往register w的中间插入内容
            " :let @w='<Ctrl-r w>其他命令'
            " https://www.brianstorti.com/vim-registers/
