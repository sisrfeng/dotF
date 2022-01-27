if [[ -z  $DISPLAY ]]; then
   # echo "DISPLAY isn't set.   it's no use setting it manually? 非也"
   export DISPLAY=localhost:11.0
   # echo '执行了:export DISPLAY=localhost:11.0 '
   # echo 'DISPLAY为空，windows terminal下也可以用tmux-yank. 但敲xlogo就会报错'
   # echo '在这点上, mobaxterm好些'
fi

echo "DISPLAY是: $DISPLAY"
