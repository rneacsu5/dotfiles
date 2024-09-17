# dotfiles

Personal and work dotfiles setup using [chezmoi](https://www.chezmoi.io/).

To setup a new device, from the home directory run:

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply rneacsu5 --purge-binary
rm -r ~/bin
mv ~/.local/share/chezmoi ~/.config/local/share
```
