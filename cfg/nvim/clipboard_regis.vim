" 和系统粘贴板打通(但隔着ssh, 到不了本地), 有了tmux_好像不用了
    noremap <Leader>y "*y
    noremap <Leader>Y "+y
    noremap <Leader>p "*p
    noremap <Leader>P "+p

    " todo:  https://vi.stackexchange.com/questions/7449/how-can-i-use-tmux-for-copying-if-i-cant-access-the-system-clipboard
        " nnoremap <silent> yy yy:call system('tmux set-buffer -b vim ' . shellescape(@"))<CR>
        " nnoremap <silent> p :let @" = system('tmux show-buffer -b vim')<cr>p$x

" echo 'vim能和tmux打通了. 有时报错 can not open display啥的. 有时又正常, 哪怕在用windows terminal, 且没开xming'





" The presence of a working `clipboard tool`    implicitly enables the '+' and '*' registers.
  " Nvim looks for these clipboard tools, in order of priority:

            "  |g:clipboard|  we can custom xclip by set g:clipboard
            "  xclip (if $DISPLAY is set)
            "  etc.....



    " 参考:https://searchcode.com/file/189000618/vim/cfg/features/clipboard.vim/
        " TRY use copy-always -- and keep yank-history by copyq(作者定义的某函数?)

        " ATT: set g:clipboard before has('clipboard')  因为
        "     https://github.com/neovim/neovim/issues/6029
        " ALT:DEV: https://neovim.io/doc/user/provider.html

        " To configure a custom clipboard tool,
        " 和xlip, xsel等并列, 但优先级更高
        " let g:clipboard = {
        "     \   'name': 'myClipboard',
        "     \   'copy': {
        "     \      '+': ['/home/linuxbrew/.linuxbrew/bin/xclip', '-selection', 'clipboard', '-silent', '-loop', '2'],
        "     \      '*': ['/home/linuxbrew/.linuxbrew/bin/xclip', 'primary', '-silent', '-loop', '2'],
        "     \    },
        "     \   'paste': {
        "     \      '+': ['/home/linuxbrew/.linuxbrew/bin/xclip', '-selection', 'clipboard', '-out'],
        "     \      '*': ['/home/linuxbrew/.linuxbrew/bin/xclip', '-selection', 'primary', '-out'],
        "     \   },
        "     \   'cache_enabled': 1,
        "     \ }
        "
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
        if hostname() == 'redmi14-leo'
        " if has('win32')
            let g:clipboard = {
                            \   'name': 'wf-win32yank-wsl',
                            \   'copy': {
                            \      '+': '/mnt/d/win32yank.exe -i --crlf',
                            \      '*': '/mnt/d/win32yank.exe -i --crlf',
                            \    },
                            \   'paste': {
                            \      '+': '/mnt/d/win32yank.exe -o --lf',
                            \      '*': '/mnt/d/win32yank.exe -o --lf',
                            \   },
                            \   'cache_enabled': 0,
                            \ }
        endif

        " xsel换成xclip, 貌似可以在wsl下用unnamedplus了. 不需要下面这些?
        " echo 'wls有bug， 禁用unnamedplus'
            " if hostname() == 'redmi14-leo' && !exists('g:vscode')
            "     " set clipboard=""  " 默认就是这样
            "
            "     " 备用方案:
            "     " wsl下:
            "     " https://github.com/equalsraf/win32yank/release
            "     " https://gist.github.com/MinSomai/c732fc66e36534feb5a8fb9e0a3c8fb2
            " endif



            " BAD: has('clipboard') needs to access provider => shows errmsg
            "   E.G. system without my 'xsel-remote' wrapper installed (ubuntu
            " FIX:
            " if (path/to/xsel == "/usr/bin/xsel" && exists('$DISPLAY') && has('clipboard')
			" if |clipboard| provider is available.
            " has({feature})	Returns 1 if {feature} is supported, 0 otherwise
                                    " 类似:
                                    " exists({expr})	The result is a Number, which is |TRUE| if {expr} is  defined, zero otherwise.
                                    " For checking if a file exists use |filereadable()|.






            if has('clipboard')  " 确认|clipboard| provider is available  (所以前面说  要先set g:clipboard  ??
                                 " 此'clipboard'是一个pseudo feature名, 不是g:clipboard这个variable
                " 导致vim内粘贴 跟远程传到本地 似的, 很慢:
                " set clipboard=unnamedplus  " 此处的clipboard, 搜帮助时敲 :help 'clipboard' (因为它是一个option, 不是variabel, 也不是feature名
                " set clipboard=unnamedplus,unnamed
                                           " 这会给 * 寄存器也复制一份
               " 对于string, ^= 表示prepend,  += 表示append
                set clipboard^=unnamed,unnamedplus
                    " To ALWAYS use the clipboard for ALL operations (instead of  interacting with the '+' and/or '*' registers explicitly)
                    " 将+寄存器 和clipboard绑定在一起?
                                    " Nvim has no direct connection to the system clipboard. Instead it depends on
                                    " a |provider| which transparently uses shell commands to communicate with the
                                    " `system clipboard` or any other `clipboard "backend"`
                                    "
                                    "
                                    " Nvim's `X11 clipboard providers` only use the PRIMARY and CLIPBOARD `selections`
                                    " for the "*" and "+" registers, respectively.
                                    "
                    " +/加号 寄存器: system clipboard on Xorg, Ctrl加x/c/y
            else
                set clipboard=unnamed
                        "  将*寄存器或clipboard绑定在一起?   * on Linux:  "mouse highlight"/"PRIMARY selection" clipboard (windows没有这技能?
                        "                                                                                                 但是mobaxterm和vscode可以啊)
                        "         on Mac OS X and Windows:
                        "                                   the * and + registers both point to:   `system clipboard`/`clipboard` (ctrl加x/c/y)
                        "                                   so unnamed and unnamedplus have the same effect:
                        "                                   the unnamed register(也就是"") is synchronized with the `system clipboard`

            endif
            set clipboard=unnamed

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
