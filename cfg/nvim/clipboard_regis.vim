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


    " The presence of a working clipboard tool implicitly enables the '+' and '*' registers.
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
    "

    " v:register	The name of the register in effect for the current normal mode  command
        "         if 'clipboard' contains "unnamed" :  *  ( clipboard on Windows
        "                                               or from  "mouse highlight"/PRIMARY selection clipboard on Linux))
                                    "unnamedplus":  +    (system clipboard on Xorg, Ctrl-x/c/y)
                                " default register: "
       " Also see |getreg()| and |setreg()|


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

        " https://searchcode.com/file/189000618/vim/cfg/features/clipboard.vim/

            " TRY use copy-always -- and keep yank-history by copyq

            " ATT: set g:clipboard before has('clipboard')
            "   https://github.com/neovim/neovim/issues/6029
            " ALT:DEV: https://neovim.io/doc/user/provider.html
            " let g:clipboard = {
            " \ 'name': 'wf_xclip',
            " \ 'copy': {
            " \   '+': 'xclip selection clipboard -silent -loop 2',
            " \   '*': 'xclip -selection primary   -silent -loop 2',
            " \  },
            " \ 'paste': {
            " \   '+': 'xclip -selection clipboard -out',
            " \   '*': 'xclip -selection primary  -out',
            " \ },
            " \ 'cache_enabled': 1,
            " \}
            "
            " BAD: has('clipboard') needs to access provider => shows errmsg
            "   E.G. system w/o my 'xsel-remote' wrapper installed (ubuntu
            " FIX:
            " if (path/to/xsel == "/usr/bin/xsel" && exists('$DISPLAY') && has('clipboard')
            if has('clipboard')
                set clipboard=unnamedplus
            else
                set clipboard=unnamed
            endif
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
