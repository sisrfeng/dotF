
#流程控制===========================
#a=10
#b=20
#if [ $a == $b ]
#then
#   echo "a 等于 b"
#elif [ $a -gt $b ]
#then
#   echo "a 大于 b"
#elif [ $a -lt $b ]
#then
#   echo "a 小于 b"
#else
#   echo "没有符合的条件"
#fi
#流程控制==========================

#shell 运算 https://zhuanlan.zhihu.com/p/264346586


#====================================================zsh function================================
#https://zsh.sourceforge.io/Doc/Release/Functions.html#Functions

#The usual alias expansion during reading will be suppressed if the autoload builtin or its equivalent is given the option -U. This is recommended for the use of functions supplied with the zsh distribution. Note that for functions precompiled with the zcompile builtin command the flag -U must be provided when the .zwc file is created, as the corresponding information is compiled into the latter.

# Figure out where to get the best help, and get it.
#
# Install this function by placing it in your FPATH and then
# adding to your .zshrc the lines:
#unalias run-help
autoload -Uz run-help

#Install this function by placing it in your FPATH and then
#adding to your .zshrc the line if you use run-help function:
autoload -Uz run-help-ip
autoload run-help-git
#====================================================zsh function==============================




# =============================================================================================
# 放到zplug的东西前 会报错
# setopt ignorebraces     #  turns off csh-style brace ({)   expansion.  不知道哪里复制来的
# 设置前:
# % echo x{y{z,a},{b,c}d}e
# xyze xyae xbde xcde
# % setopt ignorebraces
# % echo x{y{z,a},{b,c}d}e
# x{y{z,a},{b,c}d}e
# =============================================================================================


# If you want to preserve (and don't want to alter) the existing definition, you can :
# prmptcmd() { eval "$PROMPT_COMMAND" }
# precmd_functions=(prmptcmd)
