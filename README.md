# Aquila's Neovim Configuration
An my neovim configuration write from stratch. 

![screenshot](./src/2024-03-15-221218_hyprshot.png)
## How to run this thing?
### Requirement
> Forgive me if i'm missing something. Please run `:checkhealth` if you are not missing some dependencies after clone my config.

The Things|Description
---|---
Linux|i've never tried other OS and i'm currently using Arch (btw)
Git|-
Nerd Font|Search font in [here](https://nerdfonts.com) and chose one by your preference then use in your terminal (i'm using [GeistMono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/GeistMono.zip))
Neovim v10/nightly build|i would recomend using [bob](https://github.com/MordechaiHadad/bob) or just build from source in [here](https://github.com/neovim/neovim?tab=readme-ov-file#install-from-source)
Terminal|i use [kitty](https://sw.kovidgoyal.net/kitty/) and [alacritty](https://alacritty.org/).
Clipboard|If you are not using DE. Maybe you need clipboard tool. I  use `wl-copy`
C Compiler|Ensure `make` is installed too
Rust|https://www.rust-lang.org/tools/install. Ensure `cargo` is installed too
Node|I use [`fnm`](https://github.com/Schniz/fnm) as node version manager. If you need install only one version, take look in [here](https://github.com/nodesource/distributions?tab=readme-ov-file#installation-instructions)
Phyton|I'm not sure but ensure `phyton3` is installed too
`fzf`|https://github.com/junegunn/fzf
`ripgrep`|https://github.com/BurntSushi/ripgrep
`fd`|https://github.com/sharkdp/fd
Deno(Javascript Runtime)|https://deno.com/
`jq`|to format JSON output
`tidy`|to format HTML output
`curl`|-
### Run
> You can copy paste all below code and paste them in your terminal,, then press `enter` and wait until finish.

```bash
mkdir -p ~/.config && \
cd ~/.config && \
git clone https://github.com/rizkyilhampra/nvim-config.git nvim && \
cd nvim && \
nvim
```

## Thanks
All people or organization under Neovim Ecosystem and/or who i was notice in here