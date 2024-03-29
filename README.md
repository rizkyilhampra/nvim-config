# Aquila's Neovim Configuration
My personal neovim configuration written from scratch (of course, with stolen other neovim configuration from somewhere). I use this with my workflow and/or environment, see [Aquila's Dotfiles](https://github.com/rizkyilhampra/dotfilesv2).

## Screenshot
![screenshot](./src/2024-03-15-221218_hyprshot.png)
![screenshot-2](./src/2024-03-16-051038_hyprshot.png)

## Installation
### Requirements
> Forgive me if i'm missed anything. Please run `:checkhealth` to see if you are not missed some dependencies after clone/install my config.

The Things|Description
---|---
Linux|I've never tried other OS except Linux to run Neovim, so i can't promise it will work as you'are exepected if you try run in other OS. I'm currently using Arch btw
Git|
Nerd Font|Search font in [here](https://nerdfonts.com) and chose by your preference then use in your terminal (i'm using [GeistMono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/GeistMono.zip))
Neovim v10/nightly build|I would recomend using [bob](https://github.com/MordechaiHadad/bob) as Neovim version manager or build from source in [here](https://github.com/neovim/neovim?tab=readme-ov-file#install-from-source)
Terminal|Use terminal true color support. I use [kitty](https://sw.kovidgoyal.net/kitty/) and/or [alacritty](https://alacritty.org/).
Clipboard (optional)|If you are not using DE. Maybe you need clipboard tool. I use [`wl-copy`](https://github.com/bugaevc/wl-clipboard)
C Compiler|`gcc` `libstdc++`
[`make`](https://www.gnu.org/software/make/)|
Node (Javascript runtime)|I use [`fnm`](https://github.com/Schniz/fnm) as node version manager. If you need install only one version, take look in [here](https://github.com/nodesource/distributions?tab=readme-ov-file#installation-instructions)
Python|I'm not sure is needed, if you want to install ensure `python3` is installed too
[`fzf`](https://github.com/junegunn/fzf)|AFAIK it's required by telescope.nvim plugin
[`ripgrep`](https://github.com/BurntSushi/ripgrep)|
[`fd`](https://github.com/sharkdp/fd)|
[Deno (another javascript runtime)](https://deno.com/)|Required by peek.nvim plugin for showing markdown preview
[`jq`](https://github.com/sharkdp/fd) [`tidy`](https://www.html-tidy.org/) [`curl`](https://curl.se/)|Required by rest.nvim plugin (it's works like postman)
`tar` `zip` `unzip`|
[`lazygit`](https://github.com/jesseduffield/lazygit) (Optional)|
[`lazysql`](https://github.com/jorgerojas26/lazysql) (Optional)|
[`lazydocker`](https://github.com/jesseduffield/lazydocker) (Optional)|

### As default neovim configuration
> You can copy all below code and paste them in your terminal, then press `enter` and wait until finish.
```bash
mkdir -p ~/.config && \
cd ~/.config && \
git clone https://github.com/rizkyilhampra/nvim-config.git nvim && \
cd nvim && \
nvim
```
### As alias NVIM_APPNAME
> This option not make default neovim configuration instead make an alias, so you can still use your default neovim configuration
```bash
git clone https://github.com/rizkyilhampra/nvim-config.git ~/.config/ripnvim && \
NVIM_APPNAME=ripnvim nvim
```

Optional:
- Make shell alias in your shell configuration, ex in zsh:
    ```bash
    # ~/.zshrc
    alias ripnvim=NVIM_APPNAME=ripnvim nvim
    ```