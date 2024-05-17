# dotfiles

Personal and work dotfiles setup using [chezmoi](https://www.chezmoi.io/).

To setup a new device, from the home directory run:

```shell
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply rneacsu5 --ssh --purge-binary
```
