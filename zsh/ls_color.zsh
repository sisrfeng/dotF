# [[--------------------------------ls color-------------------------------------
# https: //gist.github.com/iamnewton/8754917

  # See man dircolors for the command, and man dir_colors for the configuration file syntax.
        # ISO 6429 color sequences are composed of sequences of numbers separated by semicolons.  The most common codes are:
        #
        #         0   to restore default color
        #         1   for brighter colors
        #         4   for underlined text
        #         5   for flashing text
        #        30   for black foreground
        #        31   for red foreground
        #        32   for green foreground
        #        33   for yellow (or brown) foreground
        #        34   for blue foreground
        #        35   for purple foreground
        #        36   for cyan foreground
        #        37   for white (or gray) foreground
        #        40   for black background
        #        41   for red background
        #        42   for green background
        #        43   for yellow (or brown) background
        #        44   for blue background
        #        45   for purple background
        #        46   for cyan background
        #        47   for white (or gray) background
        #
        # Not all commands will work on all systems or display devices.
        #
        # ls uses the following defaults:
        #
        # NORMAL    0           Normal (nonfilename) text
        # FILE      0           Regular file
        # DIR       32          Directory
        # LINK      36          Symbolic link
        # ORPHAN    undefined   Orphaned symbolic link
        # MISSING   undefined   Missing file
        # FIFO      31          Named pipe (FIFO)
        # SOCK      33          Socket
        # BLK       44;37       Block device
        # CHR       44;37       Character device
        # EXEC      35          Executable file
        #
        # A few terminal programs do not recognize the default properly.  If all text gets colorized after you do a directory listing, change the NORMAL and FILE codes  to
        # the numerical codes for your normal foreground and background colors.

# 当py文件是ex以后, 它就不再是原来的颜色了
#  todo:怎样忽略executable 与否?
LS_COLORS=''
LS_COLORS=$LS_COLORS:'ex=0'       # Executable file
LS_COLORS=$LS_COLORS:'no=0'           # Normal text
LS_COLORS=$LS_COLORS:'*.csv=00'
LS_COLORS=$LS_COLORS:'*.txt=0'

LS_COLORS=$LS_COLORS:'fi=47;30'       # Regular file
LS_COLORS=$LS_COLORS:'di=30'          # Directory

#不行
#LS_COLORS=$LS_COLORS:'_*_=0'        # Plain/Text

#stiky
LS_COLORS=$LS_COLORS:'tw=34;4'
LS_COLORS=$LS_COLORS:'ow=34;4'


LS_COLORS=$LS_COLORS:'ln=34;4'       # Symbolic link
LS_COLORS=$LS_COLORS:'or=01;05;31'    # broken  link

LS_COLORS=$LS_COLORS:'*.md=30;47'
LS_COLORS=$LS_COLORS:'*.py=47;33'
LS_COLORS=$LS_COLORS:'*.vim=34'

LS_COLORS=$LS_COLORS:'*.json=36;47'
LS_COLORS=$LS_COLORS:'*.jsonc=36;47'

LS_COLORS=$LS_COLORS:'*.swp=00;44;37' # Swapfiles (Vim)

# Sources
LS_COLORS=$LS_COLORS:'*.c=1;33'
LS_COLORS=$LS_COLORS:'*.C=1;33'
LS_COLORS=$LS_COLORS:'*.h=1;33'

LS_COLORS=$LS_COLORS:'*.mp4=1;35'

# 图片
LS_COLORS=$LS_COLORS:'*.jpg=1;32'
LS_COLORS=$LS_COLORS:'*.jpeg=1;32'
LS_COLORS=$LS_COLORS:'*.JPG=1;32'
LS_COLORS=$LS_COLORS:'*.gif=1;32'
LS_COLORS=$LS_COLORS:'*.png=1;32'

# Archive
LS_COLORS=$LS_COLORS:'*.tar=31'
LS_COLORS=$LS_COLORS:'*.tgz=1;31'
LS_COLORS=$LS_COLORS:'*.gz=1;31'
LS_COLORS=$LS_COLORS:'*.xz=1;31'
LS_COLORS=$LS_COLORS:'*.zip=31'
LS_COLORS=$LS_COLORS:'*.bz2=1;31'

# HTML
LS_COLORS=$LS_COLORS:'*.html=36'
LS_COLORS=$LS_COLORS:'*.htm=1;34'

 # Shell-Scripts
LS_COLORS=$LS_COLORS:'*.zsh=32'
LS_COLORS=$LS_COLORS:'*.sh=32'

LS_COLORS=$LS_COLORS:'*.n=33'

export LS_COLORS


# 等号左边:two-letter code or a file glob,
# anything that’s not a valid code will be treated as a glob, including keys that happen to be two letters long.
EXA_COLORS=$LS_COLORS

EXA_COLORS=$EXA_COLORS:'cc=33'
EXA_COLORS="reset"
export EXA_COLORS
