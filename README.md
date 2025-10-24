# GravelOS

<p align="center">
   <img src="https://upload.wikimedia.org/wikipedia/commons/a/ad/SoilTexture_USDA.svg" alt="A soil texture diagram" width="503" height="480"/>
</p>

```
.
├─ lib
│  ├─ colors
│  ├─ nix
│  └─ utils
├─ modules
│  ├─ home
│  │  ├─ cli
│  │  │  ├─ eza
│  │  │  ├─ git
│  │  │  ├─ helix
│  │  │  ├─ ov
│  │  │  ├─ prompt
│  │  │  └─ zsh
│  │  ├─ desktop
│  │  │  ├─ firefox
│  │  │  ├─ gaming
│  │  │  │  └─ openmw
│  │  │  ├─ hyprland
│  │  │  │  └─ services
│  │  │  │     └─ hypridle
│  │  │  ├─ launcher
│  │  │  ├─ mpv
│  │  │  ├─ thunderbird
│  │  │  ├─ wezterm
│  │  │  └─ xdg
│  │  └─ system
│  │     ├─ hyprland
│  │     ├─ networking
│  │     ├─ secrets
│  │     ├─ syncthing
│  │     └─ xdg
│  └─ nixos
│     ├─ cli
│     │  ├─ devEnv
│     │  ├─ git
│     │  ├─ packages
│     │  └─ zsh
│     ├─ desktop
│     │  ├─ gaming
│     │  │  └─ performance
│     │  ├─ hyprland
│     │  ├─ kde
│     │  ├─ locale
│     │  └─ login
│     └─ system
│        ├─ audio
│        ├─ boot
│        ├─ locale
│        ├─ networking
│        ├─ services
│        │  └─ nh
│        └─ user
└─ packages
   └─ desktop
      ├─ gaming
      │  ├─ pico8
      │  ├─ quadrilateralcowboy
      │  └─ steam-silent
      └─ stremio-black-icon
```

## Adding roots to prefetched sources
```
$ nix-store --add-fixed sha256 /path/to/source
/nix/store/hash-source
$ sudo nix-store --add-root /nix/var/nix/gcroots/pinned/source -r /nix/store/hash-source
```
