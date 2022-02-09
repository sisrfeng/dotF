# zsh use Zsh Line Editor (ZLE),  instead of  readline,( does not read /etc/inputrc or ~/.inputrc.)
    # todo: https://sgeb.io/posts/zsh-zle-custom-widgets/


alias bind=bindkey  # 和tmux一致
alias unbind='bindkey -r'  # 删除/清理bindkey



# stty对终端输入的设置
# ref:  ./stty_out.yml
    # Ctrl+Q is normally START (unfreeze).
    # You may not be able to change this value, because
    # the hardware (现在常见的情况，其实是终端模拟器？) may insist on using C-Q regardless of what you specify.
    # https://www.gnu.org/software/libc/manual/html_node/Start_002fStop-Characters.html

    # To remove those special characters,
        stty stop undef
        stty start undef
    # 有人这两个都设，那就照做吧
        stty -ixon #  禁用 XON/XOFF flow control
        stty -ixoff # 禁止 sending of start/stop characters
        # stty ixoff is not related to CTRL-S and CTRL-Q
    # 作用应该同上, zsh特有:
        # unsetopt flow_control  # 禁止接收 start/stop characters ？


    stty lnext "^s"  # 要  双引号括起来
        # 失败:stty lnext "\C-s"  # 要  双引号括起来

        # 记忆： s for source 原样输入
        # 默认是ctrl v，但要用来paste啊

        # type characters literally
        # 敲ctrl backspace会显示^?, 而非退格
        # 这样会把pause/break显示为ctrl z

        # only affects the terminal device line discipline internal editor
        # (the very limited one you get when running applications
        # like cat that don't have their own line editor

# 改home end等
typeset -g -A key_wf
    # -g:  do not restrict parameter to local scope
    # -A:   associative arrays

    # 来自zkbd, 根据你自己的电脑的情况设置, 比terminfo靠谱

    # function keys (commonly at the top of a PC keyboard)
        key_wf[F1]='^[OP'
        key_wf[F2]='^[OQ'
        key_wf[F3]='^[OR'
        key_wf[F4]='^[OS'
        # 亲测,确实如此. 为啥会突变?
        key_wf[F5]='^[[15~'
        key_wf[F6]='^[[17~'
        key_wf[F7]='^[[18~'
        key_wf[F8]=''''
        key_wf[F9]='^[[20~'
        key_wf[F10]='^[[21~'
        key_wf[F11]='^[[23~'
        key_wf[F12]='^[[24~'

        key_wf[Backspace]='^?'
        key_wf[Insert]='^[[2~'

        key_wf[Home]='^[[1~'
        # 等价于:
        # ^[[H
        key_wf[End]='^[[4~'
        # 等价于:
        # ^[[F

        key_wf[Delete]='^[[3~'

        key_wf[PageUp]='^[[5~'
        key_wf[PageDown]='^[[6~'

        key_wf[Up]='^[[A'
        key_wf[Down]='^[[B'
        key_wf[Right]='^[[C'
        key_wf[Left]='^[[D'
        key_wf[Menu]=''''

    bind "$key_wf[Up]" history-substring-search-up
    bind "$key_wf[Down]" history-substring-search-down
            ### 比这2行更灵活
            # bind "$key_wf[Up]" history-beginning-search-backward-end
            # bind "$key_wf[Down]" history-beginning-search-forward-end

            # 可以删掉了?

                # https://unix.stackexchange.com/a/677162/457327
                    autoload -U history-search-end
                        # autoload一个函数和source函数所在文件，效果一样？

                        # 1. autoload: 把fpath定义的函数load进来，这样才能调用。类似python的import？
                        # 2. -U  | suppress alias expansion for functions  (记作unalias?  )


                    zle -N   history-beginning-search-backward-end        history-search-end
                    zle -N   history-beginning-search-forward-end         history-search-end


    bind "$key_wf[Home]" beginning-of-line
    # `Escape character`的ascii码的十进制 十六进制 表示:
        # 八进制          \033
        # 十进制          27
        # 16进制          \x1b  或者\x1B
        # 用转义序列表示  \e
        # ctrl-key        ^[      ^是Caret(敲ctrl), 加上[ 就成了ESC


    bind "$key_wf[End]" end-of-line
    bind "$key_wf[Delete]" delete-char


    # sequence starting with `ESC [`,  即`^[[`
    # Control Sequence Introducer

# alt 负责路径跳转
    #这3行 都会显示alt作为prefix的键位
            # bind -p "\033"
            # bind -p "\e"
            # bind -p "^["

    # bind -s in-string out-string
    bind -s '\eh' '~ \n'
    # t太难按了
    # bind -s '\et' '~/.l \n'
    # w: wait: 要删除文件？wait， mv到垃圾箱吧
    bind -s '\ew' '~/.t \n'

    bind -s '\e3' '~/3 \n'
    bind -s '\ed' '~/d \n'
    # m for modify，修改配置
    bind -s '\em' '~/dotF \n'
    bind -s '\et' '~/.t \n'
    bind -s '\ec' 'cfg \n'

    bind -s "\eo" "~/omd_dotF \n"  #  alt负责路径切换

# find file
    function find-file-peco() {
        # 见alias.zsh里的f()

        if [[ `pwd` == "$HOME/d" || `pwd` == "/d" ]]
        then
            # BUFFER (scalar):   The entire contents of the edit buffer.
                # LBUFFER 如果用LBUFFER=某某 , $RBUFFER不会变
                # RBUFFER (scalar)
                # https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#index-BUFFER

            # CURSOR (integer)
                # The offset of the cursor, within the edit buffer.
                # This is in the range 0 to $#BUFFER,
                # and is by definition equal to $#LBUFFER.
                # Attempts to move the cursor outside the buffer will result in the cursor being moved to the appropriate end of the buffer.

            # 排除不了: -path "/data2/wf2/.cache_wf" -prune -o \
            # 可以排除: -path "./.cache_wf" -prune -o \

            BUFFER=$(find . \
            -path "/d/docker" -prune -o       \
            -path "$HOME/d/docker" -prune -o  \
            -path "$HOME/d/.t" -prune -o      \
            -path "$HOME/t" -prune -o         \
            -path "./.4regret" -prune -o \
            -path "./.cache_wf" -prune -o \
            -path "~/d/.4regret" -prune -o \
            -path "./.t" -prune -o            \
            -name "*$1*"  | peco --query "$LBUFFER" )
            # 别用系统的根目录下的peco，太老，用dotF下的
            CURSOR=$#BUFFER

            # echo '当前路径为： ~/d'
            # echo '(没进去搜的目录, 仍会输出一行 )'
        else
            BUFFER=$(find . \
            -path "/d/docker" -prune -o       \
            -path "$HOME/d/docker" -prune -o  \
            -path "$HOME/d" -prune -o         \
            -path "$XDG_CACHE_HOME/**" -prune -o \
            -path "~/d/.4regret" -prune -o \
            -path "./d" -prune -o             \
            -path "$HOME/d/.t" -prune -o      \
            -path "$HOME/t" -prune -o         \
            -path "./.t" -prune -o            \
            -path "/proc" -prune -o           \
            -path "/dev" -prune -o            \
            -name "*$1*"  | peco --query "$LBUFFER" )
            # 别用系统的根目录下的peco，太老，用dotF下的
            CURSOR=$#BUFFER

            # echo '不搜 ~/d 或  /d '
            # echo '(没进去搜的目录, 仍会输出一行 )'
        fi
    }
    zle -N find-file-peco

# history-peco
    function history-peco() {
        # cut -c 8-  去掉序号和空格
                        # -1000: 最近2000条历史         # 别用系统的根目录下的peco，太老，用dotF下的
        BUFFER=$(history -i -2000 |  tac | cut -c 8- | \peco --initial-filter="Regexp" --query "\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}\\s{2} $LBUFFER")
                                # tac后，最新的在最上                # 正则， 通配年-月-日 时:分:秒："\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}\\s{2}"
                                    # 命令tac装不了的话, tail也凑合
        BUFFER=${BUFFER:18}  # history加了-i，显示详细时间，回车后只取第19个字符开始的内容，（删掉时间)
            # ${parameter:start:length}
        CURSOR=$#BUFFER
        # 这个表示 数后面的字符串长度 ：$#
        # BUFFER改成其他的，不行
        # CURSOR变成小写 就不行了

        # 我没存peco的源码  “it is a single binary! You can put it anywhere you want"
    }
    zle -N history-peco

# 其实直接按k 敲命令 再tab也可以. 但如果多个python程序在跑, 就要看后面的参数
process-peco() {
    BUFFER=$(ps --headers  --user=$USER  --format=pid,start_time,cputime,stat,comm,command  | \peco --initial-filter="Regexp" --query "$LBUFFER")
    # pid最大为:4194304 (7位数字)
    BUFFER="k ${BUFFER:0:6}"
            # ${parameter:start:length}
    CURSOR=$#BUFFER
}
    # 仅供复习
    # alias psp='ps --headers  --User "${1:-$LOGNAME}" --format=pid,start_time,cputime,stat,comm,command | peco'
        # stat:  BSD style, 比state的内容详细
        # state: standard sytle
        # format里面那一堆，不能有空格

        # zsh-syntax-highlighting 把他当作unknown token
        ## 因为在alias中用了`| peco` ?  但`| head` 又没这问题

zle -N process-peco

# ctrl作为前缀：
    # 1. `\C-x',
    # 2.  `^x '  别用, 方便搜索, 并且和vim更像

        # 按2下ctrl，相当于敲了ctrl c，因为有道翻译取词翻译时，应该要悄悄复制
        bind '\C-F' find-file-peco
        bind '\C-r' history-peco
        bind '\C-b' process-peco  # b: background process

        bind '\C-S' quoted-insert
                        # self-insert  # 原样输入
        bind '\C-_' push-line-or-edit
               # ctrl /和ctrl _一样
        bind "\C-u" undo # 撤销, 好用
        # bind "\ed" undo # 撤销, 好用
        # bind "\e\d"  同上

        bind '\C-p'  up-line-or-history
        bind '\C-n'  down-line-or-history

    # ctrl alt h  和 zsh-vi-mode里, 敲shift h (后者 还不知道怎么改成 map H 0)
        # zle -N h
        #     #  h() 是我写的函数
        #     #  名字这么短, buggy ?
        # bind -s '^[^H' h  # 算了, 要用h()的话, 还是敲 h 某某某吧, 这个keybind留给run-help
        bindkey '^[^H' run-help  # zsh-vi-mode 应该把它变成 delete-forward-word. 放这里不怕被覆盖
        # bindkey '^[^h' run-help  小写导致  ctrl alt h不行

    # vi/vim/vi-mode/zsh-vi/ vicmd/viin/visual
        # visual 就是vi的visual mode
            # bind -M visual  'H' beginning-of-line  # H两边 加不加引号都可以
            # bind -M visual  'H' 'echo hi'  # 这会报错, 说没有这个widget. 要加 -s
            bind -M visual  H beginning-of-line
            bind -M visual  L end-of-line
        # vicmd对应真vim里的normal mode
            bind -M vicmd  L  end-of-line
            bind -M vicmd  H  beginning-of-line

            # todo: 参考 https://github.com/b4b4r07/zsh-vimode-visual
            # 或者直接进入vim编辑? 懒得配那么多东西

    #
    # string
        bind -s "\C-t" "tt \C-j"  # python ~/d/tmp.py  # t for try
        bind -s "\C-H" "echo '我是ctrl H，被tmux占用' \n"
        bind -s "\C-g" "echo '待用' \n"
        # bind -s "\C-o" "cle \C-j"  # 很少用
        bind -s "\C-o" "- \n"  # 和vim的体验一致

    # 待绑定：
        # C-b
        # C-8
        # C-g
        # C-Space

    # 绑定/同体
        # \C-j和\n同体？
        # \C-m 和回车键 同体
        # \C-i   # 不能改, 这货和tab同体
        # \C-q # 无法修改。一直C-u绑定
            # https://github.com/ohmyzsh/ohmyzsh/issues/7609
        # \C-[   和esc同体，别改！"

    # ctrl 空格 貌似被ahk覆盖了
    bind '\C- ' delete-word



# alt键：\e
    # These are all the same.
    #  <alt>+b <esc>+b <Meta>+b   M-b \eb
    #  e: 表示escap吧

    bind -s '\e\C-?' 'echo "wf  bind, hi" \n'  # ASCII DEL  == ^?

    # `-m' option
            # to bind tells zsh that wherever it binds an escape sequence like `\eb',
            # it  should also bind the corresponding meta sequence like `\M-b'.
            # 不加-m的话：you can rebind them separately. and if you want both sequences to be bound to a new command,
            # you have to bind them both explicitly.





# \e表示Esc键，但敲alt也行. 先按Ecs键，再按字母，等价于：按下alt，再按字母
# 默认就是吧:
# b: backward-word
# f: forward-word

bind -s '\ei' 'echo "待用" \n'
bind -s '\ep' '~/p \n'  # p for project. 当前常用的project


# todo
# DIRSTACKSIZE=15 # Setup dir stack
# setopt autopushd  pushdminus pushdsilent pushdtohome pushdignoredups cdablevars
alias rcd='cd -P ..'  # 同上
    # alias rcd='cd $(readlink -f $PWD)/ ; cd ..'  # readlink then cd ..
    # 另外:pwd -P 结果不含soft link
    bind -s '\eu' 'rcd \n' # u for up  # 不行： bind -s '<atl>+u' '..\n'

# bind -s '\ek' '.. \n'  # 目录 前进一次

# # autohotkey 使得lalt & vk88, 实现了这功能.避免干扰zsh-vim-mode:
# bind -s '\el' 'cd - \n'  # 目录 后退一次


#可以换成别的功能
bind '\eJ' beginning-of-line
bind '\eK' end-of-line
bind '\ee' backward-word

# bind '\el' forward-word  # 被插件改了？行末
#  # 不生效，被zsh vim模式插件占了？

# bind -s '\e/' 'll\n'
# 留给vim 用作复制一行并注释

bind '\ex' execute-named-cmd
# 待阅 https://www.cs.colostate.edu/~mcrob/toolbox/unix/keyboard.html




# https://sgeb.io/posts/zsh-zle-custom-widgets/
# bind -s '^[^H' 'echo "ctrl alt H"'   # 被zsh-vim-mode占用？
#
bind -s '\C-h' 'echo "被tmux占了" \n'
bind -s '\C-l'   'echo "tmux要用" \n'
# bind -r '\C-l'   # -r unbind  r记作reload吧



# autoload -U ranger
    # zle -N deer

# 改了不生效
# bind '^x^e' vi-find-next-char
# 暂时没有用的键
# bind '\C-g'


bind -s "\ei" 'ln -s "$(pwd)/"'

# 记一笔:
# \C-D在当前行 有字符时, 相当于Del
#            无字符是, 退出 (但无字符时, 按真正的Del, 不会退出)
