# 本想给leaderF用. 失败. 应该可以删掉
r(){
     echo '没搜~/.t  ~/d  /d'
     # echo '在vim中用leaderF调用rg会更好? \n'

    # --iglob:  case insensitve  的glob  # 关于大小写 好多说明，先别管
    # 之前的错误用法:
        # --glob=!"$HOME/d" \
        # --iglob=!"./.zsh_history" \

    # 可以自动补全，因为没用pipe？
     # \rg --pretty \  # 用nvim打开 ,没有彩色, 干脆不要--pretty了
     \rg                                       \
         -g '!*.zsh_history'                   \
         -g '!*.lesshst'                       \
         -g '!*.vscode-server'                 \
         -g '!.LfCache'                        \
         -g '!/d'                              \
         -g '!~/d'                             \
         -g '!/data1/weifeng_liu/.large_trash' \
         -g '!~/.t'                            \
         --hidden                              \
         --before-context 1                    \
         --after-context 1                     \
         --smart-case "$*" > ~/.t/rg_result.log
                      # regex来匹配：.表示任意一个字符
    # if [[ `cat ~/.t/rg_result.log | wc -l` > 0 ]] ; then
    if [[ $(cat ~/.t/rg_result.log | wc -l) > 0 ]] ; then
        # The backticks (`...`) is the legacy syntax required by only the very oldest of non-POSIX-compatible bourne-shells
        # and $(...) is POSIX and more preferred

        # bat代替less？ 不行  --quit-if-one-screen \
        # less无法搜中文
        # 尝试most？less的改进版
                # 失败的方法:
                # 会有乱码 nvim -c "/$*"  \
                # nvimpager 打开? 光标不好使
                # cat ~/.t/rg_result.log | $PAGER
        # less   --pattern="$*" \
            # Man!  Display the current buffer contents as a manpage.
        # nvim +10  打开文件 并到第10行,  为什么
        nvim -c "Man!" -c "/$*" \
                ~/.t/rg_result.log
                # +G 跳到最后
                # +某字母  打开时 执行vim式的操作

        echo ' '
        echo 'ps: rg搜到结果了。(less不支持中文搜索，如果看到一个空白页，就手动开less)'


        # nvim  --pattern="$*" ~/.t/rg_result.log  # 不行
        # nvim   ~/.t/rg_result.log  # 如何扔掉控制字符？
            # 内容少时，这会导致内容全在屏幕顶部
            # --smart-case "$*" |  less  --quit-if-one-screen --pattern="$*"
    else
        echo 'rg没搜到东西,不好搜就用VScode吧'
    fi
}
r $*
