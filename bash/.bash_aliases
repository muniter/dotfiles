#Connecting to my servers
alias swc="vim $HOME/.config/sway/config"
alias swch="vim $HOME/.config/sway/config.d/$(hostname).conf"
alias vr="vim $HOME/.config/nvim/init.vim"
alias df="df -h -x squashfs"
alias nn="nnn ~/Sync/notes"
alias swt="swaymsg -t get_tree | jq -C | less -R"
alias swtt="swaymsg -t get_tree | jq -c 'path(..)|[.[]|tostring]|join(\"/\")' | less -R"
alias swtv=" swaymsg -t get_tree | jq -r 'paths(scalars) as $p | [ ( [ $p[] | tostring ] | join(\".\") ) , ( getpath($p) | tojson ) ] | join(\" = \")'"
