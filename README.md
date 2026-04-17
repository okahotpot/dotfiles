# dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io).

## New machine setup

Install chezmoi:
```sh
brew install chezmoi
```

Then pull and apply everything in one command:
```sh
chezmoi init --apply git@github.com:okahotpot/dotfiles.git
```

For jiratui credentials, create `~/.config/jiratui/.env` manually
(see `~/.config/jiratui/.env.example` for the required vars).

## Daily workflow

### Pull latest from GitHub and apply
```sh
chezmoi update -v
```

### After editing a config file directly
```sh
chezmoi re-add ~/.config/zsh/
chezmoi cd
git add .
git commit -m "update zsh config"
git push
exit
```

### Adding a brand new config
```sh
chezmoi add ~/.config/newapp
chezmoi cd
git add .
git commit -m "add newapp config"
git push
exit
```

### Check what chezmoi would change before applying
```sh
chezmoi diff
chezmoi status
```

## What's tracked

| Config | Notes |
|--------|-------|
| bash | |
| fontconfig | |
| git | |
| hammerspoon | |
| jiratui | `.env` is gitignored — add credentials manually |
| lazygit | |
| nvim | |
| opencode | `node_modules` excluded |
| raycast | compiled extensions excluded |
| starship | |
| zed | |
| zellij | |
| zsh | |
