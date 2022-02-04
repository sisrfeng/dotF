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
                            \      '+': '/mnt/d/win32yank.exe -i --crlf',
                            \      '*': '/mnt/d/win32yank.exe -i --crlf',
                            \    },
                            \   'paste': {
                            \      '+': '/mnt/d/win32yank.exe -o --lf',
                            \      '*': '/mnt/d/win32yank.exe -o --lf',
                            \   },
                            \   'cache_enabled': 0,
                            \ }
                    " windows的+和*, 本来是一样的, 但这里可以改掉.
            set clipboard=unnamed
                        " wsl和windows的clipboard什么关系?
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

            " set clipboard=unnamedplus  " 看我上面定义的加号寄存器
            set clipboard=
            " xming开了也没用, 必须开moba 且在moba也连到远程
            " 之前的笔记:
                " echo 'vim能和tmux打通了. 有时报错 can not open display啥的. 有时又正常, 哪怕在用windows terminal, 且没开xming'
        endif

inoremap <C-P> <Esc>pa


" 之前在init.vim的内容:
    nnoremap vp viwp
    nnoremap vw viw
        " 想选到单词末尾, 用ve
    " 看哪个好用
        nnoremap vP Vip
        nnoremap <leader>v Vip
    " 类似于Y D C等，到行末
        nnoremap P v$<left>P
    " noremap x "_x
        " 导致(专治typo的)xp无法使用
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
