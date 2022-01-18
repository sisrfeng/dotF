这个文件没被source， 仅作为采坑笔记

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
