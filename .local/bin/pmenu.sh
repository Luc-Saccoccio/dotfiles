#!/bin/sh

icons="/home/luc/.local/share/pmenu"

cat <<EOF | pmenu | sh &
Internet
	IMG:$icons/firefox.png		firefox
	IMG:$icons/qute.png		qutebrowser
	IMG:$icons/surf.png		surf /home/luc/repos/perso/startpage/index.html
	IMG:$icons/newsboat.png		st -e newsboat
	IMG:$icons/neomutt.png		st -e neomutt
Work
	IMG:$icons/calcurse.png		calcurse
scripts
	Hiddens				dmenuhidden
	Emojis				dmenuunicode
	Games				games.sh
	Reddit				reddit
	Lock				lock.sh
EOF
