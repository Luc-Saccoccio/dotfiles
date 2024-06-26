include config.mk

BASE=$(PWD)
SCRIPTS=$(HOME)/.local/bin
MKDIR=mkdir -p
LN=ln -vsfn
PKGINSTALL=sudo -E pacman --noconfirm -S

.DEFAULT_GOAl := help
.PHONY: allinstall update allbackup

help: ## Display Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

pacmancolors: ## Make pacman and yay colorful and adds eye candy on the progress bar
	sudo sed -i "s/^#Color/Color/" /etc/pacman.conf
	sudo sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf

pac-install: ## Install arch linux packages using pacman
	$(PKGINSTALL) --needed - < $(PWD)/archlinux/pacmanlist

aur : ## Install arch linux AUR packages using yay
	yay -S --needed - < $(PWD)/archlinux/aurlist

base:
	$(PKGINSTALL) --needed base-devel

.ONESHELL:
yay: git base repos ## Install yay
	cd $(HOME)/repos/externals
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si

backup: ## Backup system packages
	$(MKDIR) $(PWD)/${OS}
ifeq ($(OS), archlinux)
	pacman -Qnq > $(PWD)/archlinux/pacmanlist
	pacman -Qqem > $(PWD)/archlinux/aurlist
else
	xpkg > ${PWD}/voidlinux/packages-list
endif

bin: ## Init all my scripts
	for file in $(shell ls ${PWD}/.local/bin); do \
		rm -f $(HOME)/.local/bin/$$file; \
		$(LN) ${PWD}/.local/bin/$$file ${HOME}/.local/bin/$$file; \
	done
	$(LN) ${PWD}/.local/share/math ${HOME}/.local/share/math
	$(LN) ${PWD}/.local/share/emojis ${HOME}/.local/share/emojis

bspwm: ## Init bspwm WM
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

catgirl: ## Init catgirl IRC client
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

desktop: ## Init all dekstop files related settings
	rm -f $(HOME)/.config/mimeapps.list
	$(LN) ${PWD}/.config/mimeapps.list ${HOME}/.config/mimeapps.list
	mkdir -p $(HOME)/.local/share/applications
	for file in html img mimeinfo pdf surf svg tab text video; do \
		rm -f $(HOME)/.local/share/applications/$$file.desktop; \
		$(LN) ${PWD}/.local/share/applications/$$file.desktop ${HOME}/.local/share/applications/$$file.desktop; \
	done

dunst: ## Init dunst notification daemon
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

git: ## Init git
	$(PKGINSTALL) $@
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

ghci: ## Init GHCi
	rm -f $(HOME)/.$@
	$(LN) ${PWD}/.$@ ${HOME}/.$@

i3: ## Init i3 WM
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

latexmk: ## Init LaTeXmk
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

texmf: ## Install my own LaTeX package
	rm -f $(HOME)/.local/share/$@
	$(LN) ${PWD}/.local/share/$@ ${HOME}/.local/share/$@

mpd: ## Init the Music Player Daemon
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

mpv: ## Init mpv media player
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

ncmpcpp: ## Init ncmpcpp mpd's interface
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

msmtp: ## Init msmtp
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

mypy: ## Init mypy
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

neomutt: msmtp ## Init neomutt mail client
	rm -f $(HOME)/.mbsyncrc $(HOME)/.config/$@
	$(LN) ${PWD}/.mbsyncrc ${HOME}/.mbsyncrc
	$(LN) ${PWD}/.urlview ${HOME}/.urlview
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

newsboat: ## Init newsboat RSS/Atom feed reader
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

newsraft: ## Init newsraft RSS/Atom feed reader
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

nimble: ## Settings for nimble
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

nvim: ## Init nvim editor
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@
	$(LN) ${PWD}/.config/pycodestyle ${HOME}/.config/pycodestyle
	$(LN) ${PWD}/.config/pylintrc ${HOME}/.config/pylintrc

picom: ## Init picom compositor
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

polybar: ## Init polybar
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

proxyman: ## Init poxyman proxy manager
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

rofi: ## Init rofi (to clean !!!)
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

scheme: ## Init Chicken Scheme
	rm -f $(HOME)/.csirc
	$(LN) ${PWD}/.csirc ${HOME}/.csirc

sxhkd: ## Init shkd hotkey daemon
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

tmux: ## Init tmux terminal multiplexer
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

vimus: ## Init vimus mpd interface
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.$@rc ${HOME}/.$@rc

X: ## Init Xmodmap and Xresources
	rm -f $(HOME)/{.Xmodmap,.Xresources}
	$(LN) ${PWD}/.Xmodmap ${HOME}/.Xmodmap
	$(LN) ${PWD}/.config/X11 ${HOME}/.config/X11

xmonad: ## Init xmonad WM
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

xmobar: ## Init xmobar
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

xob: ## Init xob
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

zathura: ## Init zathura PDF viewer
	rm -f $(HOME)/.config/$@
	$(LN) ${PWD}/.config/$@ ${HOME}/.config/$@

zsh: ## Init zsh shell
	rm -f $(HOME)/.config/$@ $(HOME)/.profile
	$(LN) ${PWD}/.profile ${HOME}/.profile
	$(LN) ${PWD}/.config/zsh ${HOME}/.config/zsh
	# sudo echo 'export ZDOTDIR="\$HOME"/.config/zsh' > /etc/zsh/zshenv -- TODO

texbackup: ## Backup TeX packages
	$(MKDIR) $(PWD)/${OS}
	tlmgr info --only-installed --data "name" > $(PWD)/${OS}/installed_package.txt

texrecover: ## Recover tex packages
	tlmgr install $(shell cat ${PWD}/${OS}/installed_package.txt)

repos: git ## Create the repos directory and clone a few repos
	$(MKDIR) $(HOME)/repos/perso
	$(MKDIR) $(HOME)/repos/externals

.ONESHELL:
ext-repos: repos
	cd $(HOME)/repos/externals
	git clone https://github.com/tsoding/boomer
	git clone https://notabug.org/PangolinTurtle/BLAG-fortune
	git clone https://git.causal.agency/catgirl
	git clone https://github.com/OliverLew/fontpreview-ueberzug
	git clone https://github.com/himanshub16/ProxyMan

.ONESHELL:
dmenu: ## Clone dmenu
	cd $(HOME)/repos/perso
	git clone https://github.com/Luc-Saccoccio/dmenu

.ONESHELL:
dwm: ## Clone dwm
	cd $(HOME)/repos/perso
	git clone https://github.com/Luc-Saccoccio/dwm

.ONESHELL:
dwmblocks: ## Clone dwmblocks
	cd $(HOME)/repos/perso
	git clone https://github.com/Luc-Saccoccio/dwmblocks

.ONESHELL:
st: ## Clone st
	cd $(HOME)/repos/perso
	git clone https://github.com/Luc-Saccoccio/st

.ONESHELL:
tabbed: ## Clone tabbed
	cd $(HOME)/repos/perso
	git clone https://github.com/Luc-Saccoccio/tabbed

suckless: dmenu dwm st dwmblocks tabbed

testpath: ## Echo PATH
	PATH=$$PATH
	@echo $$PATH
	GOPATH=$$GOPATH
	@echo $$GOPATH

update:
	@echo "Python: pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U"
	@echo "Arch Linux: yay -S"
	@echo "Void Linux: xi -Su"
	@echo "LaTeX: tlmgr update --all"

allinstall: install aur pip piprecover tex bin bspwm catgirl desktop dunst git i3 mpd mpv ncmpcpp neomutt newsboat nvim picom polybar proxyman sxhkd tmux X xmonad zathura zsh repos suckless
allconfig: bin bspwm catgirl desktop dunst git i3 mpd mpv ncmpcpp neomutt newsboat nvim picom polybar proxyman sxhkd tmux X xmonad zathura zsh

archinstall: install nvim neomutt suckless yay pacmancolors aur bin

allbackup: backup texbackup
