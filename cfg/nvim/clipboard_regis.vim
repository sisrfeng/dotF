" echo 'vim能和tmux打通了. 有时报错 can not open display啥的. 有时又正常, 哪怕在用windows terminal, 且没开xming'
    " echo 'vim复制到本地, 弃疗吧??'
    " echo 'wls有bug， 别设unnamedplus'
    " update: xsel换成xcliip, 貌似可以在wsl下用unnamedplus了
        " if hostname() == 'redmi14-leo' && !exists('g:vscode')
        "     " set clipboard=""  " 默认就是这样
        "
        "     " 备用方案:
        "     " wsl下:
        "     " https://github.com/equalsraf/win32yank/release
        "     " https://gist.github.com/MinSomai/c732fc66e36534feb5a8fb9e0a3c8fb2
        " endif


" The presence of a working `clipboard tool`    implicitly enables the '+' and '*' registers.
" Nvim looks for these clipboard tools, in order of priority:


    " - |g:clipboard|

    " - xclip (if $DISPLAY is set)
    " - xsel (if $DISPLAY is set)
    "
    " - lemonade (for SSH) https://github.com/pocke/lemonade
    " - doitclient (for SSH) http://www.chiark.greenend.org.uk/~sgtatham/doit/
    "
    " - win32yank (Windows)
    "
    " - tmux (if $TMUX is set)



    " v:register	The name of the register in effect for the current normal mode  command
    " v:register 取值情况:
        "  if 'clipboard' contains "unnamed" :
            "
                                " unnamedplus":
                            " default register:  " (双引号)
       " Also see |getreg()| and |setreg()|



        " 参考:https://searchcode.com/file/189000618/vim/cfg/features/clipboard.vim/
            " TRY use copy-always -- and keep yank-history by copyq(作者定义的某函数?)

            " ATT: set g:clipboard before has('clipboard')
            "     https://github.com/neovim/neovim/issues/6029
            " ALT:DEV: https://neovim.io/doc/user/provider.html

            let g:clipboard = {
                \   'name': 'myClipboard',
                \   'copy': {
                \      '+': ['/usr/binxclip', '-selection', 'clipboard', '-silent', '-loop', '2'],
                \      '*': ['xclip', '-selection', 'primary', '-silent', '-loop', '2'],
                \    },
                \   'paste': {
                \      '+': ['/usr/binxclip', '-selection', 'clipboard', '-out'],
                \      '*': ['/usr/binxclip', '-selection', 'primary', '-out'],
                \   },
                \   'cache_enabled': 1,
                \ }

            let g:clipboard = {
                \   'name': 'myClipboard',
                \   'copy': {
                \      '+': ['tmux', 'load-buffer', '-'],
                \      '*': ['tmux', 'load-buffer', '-'],
                \    },
                \   'paste': {
                \      '+': ['tmux', 'save-buffer', '-'],
                \      '*': ['tmux', 'save-buffer', '-'],
                \   },
                \   'cache_enabled': 1,
                \ }
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
            "
            " BAD: has('clipboard') needs to access provider => shows errmsg
            "   E.G. system without my 'xsel-remote' wrapper installed (ubuntu
            " FIX:
            " if (path/to/xsel == "/usr/bin/xsel" && exists('$DISPLAY') && has('clipboard')
			" if |clipboard| provider is available.
            " has({feature})	Returns 1 if {feature} is supported, 0 otherwise
                                    " 类似:
                                    " exists({expr})	The result is a Number, which is |TRUE| if {expr} is  defined, zero otherwise.
                                    " For checking if a file exists use |filereadable()|.
            if has('clipboard')
                set clipboard=unnamedplus
                " set clipboard=unnamedplus,unnamed
                "                           这会给 * 寄存器也复制一份
                " set clipboard=
                            " 将+寄存器 和clipboard绑定在一起?  (+寄存器:  system clipboard on Xorg, Ctrl-x/c/y,  对应windows的*寄存器?)
                    " To ALWAYS use the clipboard for ALL operations (instead of
                    " interacting with the '+' and/or '*' registers explicitly)
                    " 导致vim内粘贴 跟远程传到本地 似的, 很慢
            else
                set clipboard=unnamed
                        "  将*寄存器或clipboard绑定在一起?   * on Linuxor:  "mouse highlight"/PRIMARY selection clipboard (windows没有这技能)
                        "                                    * on Windows: clipboard (ctrl-x/c/y)
            endif
            set clipboard=

            " 和系统粘贴板 "+ 打通
            " vim外也可以粘贴vim的registry了
            " inoremap <C-V> "+p
                " 之前为啥要这行? 不加也是粘贴
            " iunmap <c-v>
            "   加了这行,导致ctrl c不能成为i_ctrl-v

            inoremap <C-P> <Esc>pa

            " xsel:

                    " --input             -i  | read standard input into the selection
                    "  --clipboard         -b  | operate on the CLIPBOARD selection
                    "  --primary           -p  | operate on the PRIMARY selection (default)
                    " --secondary         -s  | operate on the SECONDARY selection

            " xclip
                    " xclip reads text from standard input or files and makes it available to
                    " other X applications for pasting as an X selection (traditionally with the middle  mouse  button).
                    " It reads from all files specified, or from standard in, if no files are specified.
                    " xclip can also print the contents of a selection to standard out with the -o option.

                    " The default action is to silently  wait  in  the  background  for `X selection requests (pastes)`
                    " until another X application places data in the clipboard, at which point xclip exits silently. You can use
                    " the -verbose option to see if and when xclip actually receives
                    " selection requests from other X applications. (命令行的貌似不算)



" 和系统粘贴板打通(但隔着ssh, 到不了本地), 有了tmux_好像不用了
noremap <Leader>y "*y
noremap <Leader>Y "+y
noremap <Leader>p "*p
noremap <Leader>P "+p

" todo:  https://vi.stackexchange.com/questions/7449/how-can-i-use-tmux-for-copying-if-i-cant-access-the-system-clipboard
    " nnoremap <silent> yy yy:call system('tmux set-buffer -b vim ' . shellescape(@"))<CR>
    " nnoremap <silent> p :let @" = system('tmux show-buffer -b vim')<cr>p$x
