这个文件没被source， 仅作为采坑笔记

        " https://github.com/vim/vim/issues/6793
        " Register % contains the name of the current file.
        " 这3行结果貌似一样, expand和fnamemodify只有细微区别？
        " let $no_vscode = expand('%:h') . "/no_vscode.vim"
        " let $no_vscode = fnamemodify('%',':h') . "/no_vscode.vim"


- expand/扩展/识别 文件名
        都不行:
        " let $has_vscode = fnamemodify($MYVIMRC,':h') . "/has_vscode.vim"
        " let $has_vscode = expand('%:h') . "/has_vscode.vim"
        " let $has_vscode = fnamemodify('%',':h') . "/has_vscode.vim"


        " echom 'has_vscode找到了吗'
        " echom $has_vscode

- autocmd
        " 错误的根源:  作为autocmd的{pat},  ~ 无法expand为家目录 (但echo $no_vscode时又可以）
        let $no_vscode = "~/dotF/cfg/nvim/no_vscode.vim"

        " Note that special characters (e.g., "%", "<cword>") in the ":autocmd"
        " arguments are not expanded when the autocommand is defined.
        " These will be  expanded when the Event is recognized, and the {cmd} is executed.
        " The only  exception is  "<sfile>"
        "
        "
        怎么发现的？

        :augroup wf_reload ， 输出的结果发现， 想要的autocmd定义成功, {pat}是：~/dotF/cfg/nvim/no_vscode.vim

        " let no_vscode = 'hihi'
        " XX 和 $XX 可以独立，看看echo $XX 和 echo XX
        "
        " let no_vscode = 'hihi'
        " XX 和 $XX 可以独立，看看echo $XX 和 echo XX

        " 最终成功的关键一行
        autocmd wf_reload BufWritePost $no_vscode  ++nested   source $MYVIMRC |  echom 'hi'

        " 没那么好：
        autocmd wf_reload BufWritePost no_vscode.vim  ++nested   source $MYVIMRC |  echom 'hi1'
        autocmd wf_reload BufWritePost *no_vscode.vim  ++nested   source $MYVIMRC |  echom 'hi2'

        " 其他想法
        " " 这3个都不行
        " autocmd wf_reload BufWritePost no_vscode   echom '你看'
        " autocmd wf_reload BufWritePost $no_vscode  echom '你看'
        " autocmd wf_reload BufRead     $no_vscode  echom '你看'
        " autocmd wf_reload BufRead    *no_vscode.vim       echom '你看'
        " autocmd wf_reload BufWritePost     $no_vscode       echom ' 能识别了：  $no_vscode （环境变量）'
        " The environment variable is expanded when the autocommand is defined, not when
        " the autocommand is executed.  This is different from the command!

        " 明明别人都说行的啊 https://vi.stackexchange.com/questions/28110/can-i-use-a-variable-in-autocmd-pat
        " 而且最后这行也成功了啊：
        " source $in_vscode
        " 这样可以
        " autocmd wf_reload BufWritePost no_vscode.vim  echom "你看, 能识别$no_vscode:" | echom $no_vscode | echom ' '
        " todo https://vi.stackexchange.com/questions/6830/putting-the-value-of-an-argument-into-part-of-a-regex-in-vimscript

        " todo: 改成在rc.zsh里定义$no_vscode ?
        "
        "
        "
        " ++nested ，老版本中是nested
                    " Problem:    Making an autocommand trigger once is not so easy.
                    " Solution:   Add the ++once argument.  Also add ++nested as an alias for
                                "nested". (Justin M. Keyes, closes #4100)


        " `:autocmd` adds to the list of autocommands regardless of whether they are
                " already present.  When your .vimrc file is sourced twice, the autocommands
                " will appear twice.  To avoid this, define your autocommands in a group, so
                " that you can easily clear them:



        " When a function by this name already exists and [!] is
        " not used an error message is given.  There is one
        " exception: When sourcing a script again, a function
        " that was previously defined in that script will be
        " silently replaced.
        " When [!] is used, an existing function is silently
        " replaced.  Unless it is currently being executed, that
        " is an error.
        " NOTE: Use ! wisely.  If used without care it can cause
        " an existing function to be replaced unexpectedly,
        " which is hard to debug.

        " 改了 beautify_wf并保存后， 保存init.vim会说function already exist
        " 些别想着避免这个问题，毕竟很少改init.vim以外的文件.
        " https://github.com/xolox/vim-reload

-  " 禁用netrw，不过应该用不着了。我删掉了对应文件
        " let g:loaded_netrw       = 1
        " let g:netrw_banner=0
        " let g:loaded_netrwPlugin = 1



-  " " 竖着分屏打开help
        " augroup my_filetype_settings
        "     autocmd!
        "     " winnr: 当前window的编号，top winodw是1
        "     " $  表示 last window
        "     autocmd FileType help if winnr('$') > 2 | wincmd K | else | wincmd L | endif
        "     augroup end

        " 1.4 LISTING MAPPINGS                  *map-listing*
        " When listing mappings the characters in the first two columns are:

        "       CHAR    MODE    ~
        "      <Space>  Normal, Visual, Select and Operator-pending
        "     n Normal
        "     v Visual and Select
        "     s Select
        "     x Visual
        "     o Operator-pending
        "     ! Insert and Command-line
        "     i Insert
        "     l ":lmap" mappings for Insert, Command-line and Lang-Arg
        "     c Command-line
        "     t Terminal-Job
        "
        " Just before the {rhs} a special character can appear:
        "     * indicates that it is not remappable
        "     & indicates that only script-local mappings are remappable
        "     @ indicates a buffer-local mapping


" *i_CTRL-X* *insert_expand*
        " CTRL-X enters a sub-mode where several commands can be used.  Most of these
        " commands do keyword completion; see |ins-completion|.


        " no help for <C-X>
        " no help for CTRL-X CRTL-O
        " 这样才行：
        " h i_CTRL-X


" ms-windows
        " 这样可以 不那么死板地 只能用~/AppData/Local/nvim/init.vim来进入windows的nvim, 从而管理插件(
        " windows的nvim和vscode的nvim共用):
        "nvim -u '\\wsl$\Ubuntu\root\dotF\.config\nvim\init.vim'
        " 插件位置:
        " C:\Users\noway\AppData\Local\nvim-data
        " 把wsl下的dotfile发送快捷方式到 ~/AppData/Local/nvim/init.vim , 不行.因为shortcut和软链接还不一样
        " https://superuser.com/questions/253935/what-is-the-difference-between-symbolic-link-and-shortcut


" Return to last edit position when opening files
        " autocmd BufReadPost * normal! g`"zv
        " 有bug:
        "  normal! 表示 Execute Normal mode commands,
        "  [!] :  mappings will not be used.
        "  g`"表示 跳到 the last known position in a file
        "  zv 取消折叠光标所在行
        " 如果: the file is truncated outside of vim, and vim's mark is on a line that no longer exists, vim throws an error. Fixed that with:
        " autocmd BufReadPost * silent! normal! g`"zv
        " 或者:


" 这么写比较啰嗦：
"
" let s:beauty_path = fnamemodify($MYVIMRC, ":p:h") . "/beautify_wf.vim"    " 字符串concat，用点号
" exe 'source ' . s:beauty_path      " 这样不行： source  . s:beauty_path
