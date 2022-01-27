# todo
# https://unix.stackexchange.com/questions/27236/zsh-autocomplete-ls-command-with-directories-only
#
# 自带的命令的补全文件, 比如_kill等, 在:/usr/share/zsh/functions/Completion/Zsh

# rc.zsh里已经有这行了
# autoload -U compinit
         # -U : suppress alias expansion for functions

zmodload zsh/complist

# setopt
    setopt AUTO_LIST
    setopt AUTO_MENU
    setopt MENU_COMPLETE #补全时 直接选中菜单项
    setopt LIST_ROWS_FIRST
    setopt LIST_PACKED  # 排得更紧凑
    setopt GLOB_COMPLETE #  Trwigger the completion after a * instead of expanding it.
                        # 先看一下匹配的是啥, 再批量操作
    # setopt AUTO_PARAM_SLASH # 危险! 尤其是rm soft link时


zstyle ':completion:*' completer           \
                                _complete  \
                                _prefix    \
                                _match     \
                                _approximate \
                                _correct  \
                                # _extension :别用了,  _main_complete:208: command not found: _extension, 没找到solution
                                # 放前面的优先
    # 有一次 _complete后没加 \ , 不报错, 但后面的_prefix等不生效, 因为_prefix等 是shell function, 可以在命令行里直接输入
    # zstyle ':completion:*' completer           \
    #                                 _complete
    #                                 _prefix
        # _correct:  main completer
        # Ctrl+x  h:  默认 调用这个completer: _complete_help

zstyle ':completion:*'          use-cache        on
zstyle ':completion:*'          cache-path       "$XDG_CACHE_HOME"
zstyle ':completion:*'          verbose          yes
zstyle ':completion:*'          menu             select serach
# zstyle ':completion:*'        menu             select
                                                       #serach: allow you to fuzzy-search the completion menu
    bindkey -M menuselect '^xi' vi-insert  # 这里为vi-insert让路?
                                                # CTRL+x i  # interactivem  弹出补全后, 可以输入, 进而filter

zstyle ':completion:*'          list-separator   '|'
# zstyle ':completion:*'        file-list all         # 太详细, ls -ll似的
zstyle  ':completion:*:*:cp:*'  file-sort     modification reverse
                                            # cp时, 最近修改的先弹出来?




# =================按tab自动补全的颜色
        # zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
        # (s.:.) 作用是把 这长串的冒号去掉 :ex=00:no=0:*.csv=00:*.txt=0:
        # (s.e.)  去掉e   regex?  /s/e/

        zstyle ':completion:*'                          list-colors '=*=0'     #   如果不加这行，可能之前的配置留下了编译后的文件，导致不想要的老效果还留着
        zstyle ':completion:*:commands'                 list-colors '=*=32'
        zstyle ':completion:*:options'                  list-colors '=^(| *)=34'     # `^` 表示取反  * 表示任意

        zstyle ':completion:*:*:kill:*:processes'       list-colors '=(#b) #([0-9]#)*=0=01;31'
            # zstyle ':completion:*:*:kill:*'                 list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'

        # zstyle ':completion:*:aliases'                list-colors '=*=2;38;5;128'
        # zstyle ':completion:*:builtins'               list-colors '=*=38;5;142'
        # zstyle ':completion:*:parameters'             list-colors '=*=32'



# >_>_>==================过滤external-command======
        zstyle ':completion:*:matches'                  group 'yes'  # 用户所在分组信息,
                                                                       # 不设好像也可以
        zstyle ':completion:*'                          group-name ''
            # all different types of matches 分门别类显示
            # All matches for which no group name is defined :  put in a group named -default-
        ##加了没变化:
        zstyle ':completion:*:*:-command-:*:*'          group-order '\
                                                                    shell-function |\
                                                                    alias          |\
                                                                    builtins'
                                                                    # functions 即 shell functions
                                                                    # commands  即 external commands
                                                                # Remaining tags will be tried if 没找到上述的
                                                                #
        zstyle ':completion:*:*sh:*:' tag-order files
        zstyle ':completion:*:complete:-command-:*:*'   tag-order                   \
                                                                'local-directories'
                                                                # 'external-command'
                                                                # 多个单引号引住的内容, 最前的优先冒出来
        ## 加了没变化:
        # The _ignored completer can appear in the list of completers to restore the ignored matches.
        zstyle ':completion:*'                          ignored-patterns           \
                                                                'commands'         \
                                                                'user'
        zstyle ':completion:*:*:-command-:*:*'          ignored-patterns 'l2ping|l2test'
                                                        # 下面的没有d, 也不是pattern, 看清楚
        zstyle ':completion:*:cd:*'                     ignore-parents parent pwd user
        # todo: 了解_kill等文件 具体原理


# ===================format
                                                                         #  %d  表示补全类型
        zstyle ':completion:*:*:*:*:descriptions'        format $'\e[01;33m %d \e[0m'
        zstyle ':completion:*:(approximate|correct)'     format  '%F{yellow}近似|校正_%d for %o (错误: %e)%f'
        zstyle ':completion:*:*expansions'               format  '%F{cyan}扩展_%d for %o%f'
        zstyle ':completion:*:warnings'                  format $'\e[01;31m 无补全 \e[0m'
        zstyle ':completion:*:messages'                  format $'\e[01;35m 补全信息 %d --\e[0m'
        zstyle ':completion:*:*:*:*:corrections'         format $'\e[38;2;10;230;10m 校正 (错误字数: %e) \e[0m'   #  [38;2;{r};{g};{b}m  真彩色 true colors

        zstyle ':completion:*:options'                   description 'yes'
        zstyle ':completion:*:options'                   auto-description '%d'
        zstyle ':completion:*:default'                   list-prompt '%S%m 不知道什么时候生效 matches | line %l | %p%s'
                                                                     # %S：standout mode
        zstyle ':completion:*:default'                   select-prompt '%m 候选 | %l 行'  # 补全时最底下的一栏



zstyle ':completion:*:*:default'         force-list always





##路径补全
        zstyle ':completion:*' expand 'yes'
        zstyle ':completion:*' squeeze-shlashes 'yes'

##修正大小写
        zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

##错误校正
        #zstyle ':completion:*:match:*'        original only
        zstyle ':completion:*:approximate:*'   max-errors 3 numeric
        # 下面的内容不太理解:
        #zstyle ':completion::prefix-1:*' completer _complete
        #zstyle ':completion:predict:*' completer _complete
        #zstyle ':completion:incremental:*' completer _complete _correct

##kill 命令
        #compdef pkill=kill
        #compdef pkill=killall
        zstyle ':completion:*:*:*:*:processes' command   'ps --user=$USER --format=user,command'
                                                                                        # comm显示的信息太少
                                                                                        # com一定要放在第二,不知道为啥
                # zstyle ':completion:*:*:*:*:processes' command 'ps -au'
                # zstyle ':completion:*:*:*:*:processes' command   'ps --user=$USER --format=user,command,stat,pid' # 后面的内容挡住command的完整信息了
                # 复杂情况下, 还是htop的filter搜得准, tab补全能搜命令, 但搜不到命令的参数
                #
# 还是不生效
zstyle ':completion:*:*:-command-:*:*'           group-order \
                                                            shell-function \
                                                            alias     \
                                                            builtins
                                                            # functions 即 shell functions
                                                            # commands  即 external commands
                                                        # Remaining tags will be tried if 没找到上述的
zstyle ':completion:*' squeeze-slashes false
    #  cd ~//Documents will be expanded to cd ~/*/Documents.

zstyle ':completion:*' matcher-list   ''    'm:{a-zA-Z}={A-Za-z}'
    # first try the usual completion
    # if nothing matches, to try a case-insensitive completion:

# complete partial words you’ve typed
zstyle ':completion:*' matcher-list   ''    'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    # This style would allow you, for example, to complete the file _DSC1704.JPG
    # if you only try to complete its substring 1704.
    # The patterns themselves are quite 复杂

zstyle ':completion:*' users  # 不要弹出任何用户名
            # provide the empty list as the list of users
