# TODO
- Install
	- `ripgrep`
	- `meld`
	- Rewritten gnu programs https://zaiste.net/posts/shell-commands-rust/
	- `starship` prompt (https://github.com/goolord/simple-zsh-nix-shell)
	- A terminal file manager (`xplr`, `nnn` `ranger`). `zoxide` has some plugins for those
	- `xcp`
	- `thunderbird`
	- `zen` browser or `floorp` or `ladybird` when it comes out
	- `delta` as a diff substitute
- Configure
	- `ov` with `less` keybindings. https://noborus.github.io/ov/index.html
	- `stylix`
		- https://github.com/Misterio77/nix-colors
		- GTK themes, window border styles, mouse cursors, etc
			- make a fotonight web theme
	- Dualshock 4 controller
	- Configure `gpg` and make it non-mutable
- Disk management
	- [ ] Use `disko`
	- [x] Enable ztsd compression and defragment BTRFS disk
		- [ ] Look further into ztsd levels
	- [ ] Put wine prefixes into a subvolume and create a duperemove service. https://www.reddit.com/r/linux_gaming/comments/1fig0xy/comment/lnh1x6u/
	- [ ] Look into `btrfs` snapshots saved on primary ssd
	- [ ] BTRFS scrubbing https://nixos.wiki/wiki/Btrfs#Scrubbing
- Make a color palette lib for the whole system. https://github.com/mxxntype/Aeon-snowfall
	- `ov`
	- `tealdeer`
	- `eza` https://github.com/eza-community/eza/blob/main/docs/theme.yml
	- `gitui`
- Make a script running on the first open interactive shell every login with MOTD stuff such as `cowsay`, `fortune` or https://tealdeer-rs.github.io/tealdeer/tips_and_tricks.html#showing-a-random-page-on-shell-start
- Look further into Lix, Tvix and Ekala
- Look into `VNC` or `RDP` screen sharing
- Do something with `systemctl reboot --boot-loader-entry=auto-windows`
- An RSS or atom feed?
- Learn terminal multiplexing
- use and configure a torrent daemon like transmission or rtorrent
- syncthing
- flashpoint
- add alias for nix-store --query --requisites /run/current-system | grep ...
- look into schedulers, BORE and services.scx
- look into https://github.com/etu/nixconfig
- spread TODO around repo and delete TODO file
- https://darkone-linux.github.io/
- https://git.atagen.co/atagen/ides
- https://github.com/poly2it/kein
- https://github.com/fufexan/nix-gaming/tree/master
- see about replacing kde wallet with gnome keyring
