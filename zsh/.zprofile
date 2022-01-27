# 名字没有.zlogin直观
# 暂时没啥用

# .zprofile is basically the same as .zlogin
# except that it's sourced before .zshrc
# zprofile is meant as an alternative to .zlogin for ksh fans;
# the two are not intended to be used together,
# although this could certainly be done if desired."

# Commands are then read from $ZDOTDIR/.zshenv.
# If the shell is a login shell, commands are read from /etc/zsh/zprofile and then $ZDOTDIR/.zprofile.
# if the shell is interactive, commands are read from /etc/zsh/zshrc and then $ZDOTDIR/.zshrc.
# if the shell is a login shell, /etc/zsh/zlogin and $ZDOTDIR/.zlogin are read.

# echo '===========开了login的zsh, 调用: ~/.zprofile'
# echo $WF_USE_ETC_ZSH_ZSHENV
# echo '===========结束调用 \n'

