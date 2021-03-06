# dotfiles

This repo contains some of the common programs and configurations I use
when bootstrapping a new machine.

## Basics

1. Install [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)

2. `xcode-select --install`

3. Install [Homebrew](http://brew.sh)

4. `brew install git mercurial lua openssl redis postgres`

5. `mkdir -p ~/dev/src/github.com/tysonmote && cd ~/dev/src/github.com/tysonmote && git clone https://github.com/tysonmote/dotfiles.git`

6. `cd dotfiles && ./bootstrap.sh`

7. Install [Input Mono](http://input.fontbureau.com) and [Fira Code](https://github.com/tonsky/FiraCode)

8. `cd ~/.janus && ./fetch_all_plugins.sh`
