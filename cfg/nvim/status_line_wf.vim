
" todo
set showtabline=2

" Each status line item is of the form: ( All fields except the {item} are optional.)
"       %-0{minwid}.{maxwid}{item}
" 在上面的基础上：  (几表示某个highlight设置)
" %Highlight配色号码

"    %=   右对齐
"    %r  readonly, 显示 [RO]
" set statusline=
" set statusline=%7*=%r
" set statusline=%=%t                            " tittle
" set statusline+=%=\ buffer号:%n\            "buffer number
" set statusline+=%=%m                         "modified flag
" " set statusline+=%=文件格式:%{&ff}            "是否unix
" " flag[Preview] ??
" set statusline+=%=\ %h
" set statusline+=%=\ %w
" set statusline+=%=\ %k
" set statusline+=%=\ %q
" set statusline+=%999X
" " set statusline+=
" set statusline+=%=第%l行/
" set statusline+=%L行               "total lines
" set statusline+=(%p%%)
" set statusline+=%=第%v列         "virtual column number (screen column)
" " set statusline+=\ %c           " Column number (byte index).
"
"
set laststatus=2  "  always show statusline

hi User1 guifg=#ffdad8  guibg=#000a99
set statusline=
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%0*\ \ %r%w\                       " Readonly? Top/bot.
set statusline+=%2*\[buf号:%n]                                  "buffernr  " buffer号码
set statusline+=%8*\ %=\ 行:%l/%L\ (%3p%%)\             "Rownumber/total (%)
set statusline+=%9*\ 列:%3c\                            "Colnr

" set statusline+=%2*\ %y\                                  "FileType
" set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
" set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
" set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
" set statusline+=%5*\ %{&spelllang}\                         "Spellanguage
" set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

" set laststatus=1  " only if there are at least two windows
" 没有statusline时，命令那行和代码容易混在一起

" put the following lines in your current colorscheme file??
    "  貌似不能放进colorscheme file.
    " hi User1 guifg=#ffdad8  guibg=#880c0e

