# Dotfiles

This is my collection of [configuration files](https://dotfiles.github.io/).

## Usage

Clone this repository, and create symbolic links using [GNU Stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/) : 
```shell
gt clone git@github.com:Luc-Saccoccio/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow nvim zsh # whatever else you'd like
```

## Advanced description

### Organization

Each directory contains a representation of the home directory, and contains one program configuration files.

### Scripts

All of the scripts I wrote or took are located in `bin/.local/bin`, just type
```shell
stow bin
```
to have them installed on your local bin. Don't forget to add `.local/bin` to your PATH !

### Configuration files

There are settings for :
  * [X](https://x.org/wiki/) (X server)
  * [catgirl](https://git.causal.agency/catgirl/) (IRC client)
  * [bspwm](https://github.com/baskerville/bspwm) (WM)
  * [dunst](https://github.com/dunst-project/dunst) (notifications)
  * [git](https://git-scm.com/) (really need any explanation ?)
  * [i3](https://github.com/Airblader/i3/tree/gaps-next) (WM)
  * [mpd](https://github.com/MusicPlayerDaemon/MPD) (music player daemon)
  * [mpv](https://github.com/mpv-player/mpv) (media player)
  * [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp) (tui for mpd)
  * [neomutt](https://github.com/neomutt/neomutt) (MUA)
  * [neovim](https://github.com/neovim/neovim) (editor)
  * [newsboat](https://github.com/newsboat/newsboat) (RSS)
  * [picom](https://github.com/yshui/picom) (compositor)
  * [polybar](https://github.com/polybar/polybar) (bar)
  * [proxyman](https://github.com/himanshub16/ProxyMan) (proxy manager)
  * [rofi](https://github.com/davatorium/rofi) (program launcher)
  * [sxhkd](https://github.com/baskerville/sxhkd) (key binder)
  * [termite](https://github.com/thestinger/termite/) (terminal)
  * [tmux](https://github.com/tmux/tmux) (terminal multiplexer)
  * [vimus](https://github.com/vimus/vimus) (tui for mpd)
  * [zathura](https://github.com/pwmt/zathura) (document viewer)
  * Others things like aliases, mimeapps, shell and variable config, and Xressources

### Programs
Check all my other repositories : 
  * [dwm](htpps://github.com/Luc-Saccoccio/dwm)
  * [dwmblocks](htpps://github.com/Luc-Saccoccio/dwmblocks)
  * [st](htpps://github.com/Luc-Saccoccio/st)
  * [dmenu](htpps://github.com/Luc-Saccoccio/dmenu)
  * [tabbed](htpps://github.com/Luc-Saccoccio/tabbed)

## License

[WTFPL](http://www.wtfpl.net/).

## TODO
* [ ] Include screenshots
* [ ] Try to switch from `stow` to a `Makefile`
