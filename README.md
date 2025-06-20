# GravelOS

<p align="center">
   <img src="https://upload.wikimedia.org/wikipedia/commons/a/ad/SoilTexture_USDA.svg" alt="A soil texture diagram" width="503" height="480"/>
</p>

```
.
├─ lib
│  ├─ gravelOS
│  ├─ nix
│  └─ secrets
└─ modules
   ├─ nixos
   │  ├─ system
   │  │  ├─ audio
   │  │  ├─ boot
   │  │  ├─ locale
   │  │  ├─ networking
   │  │  ├─ services
   │  │  │  └─ nh
   │  │  └─ user
   │  ├─ cli
   │  │  ├─ devEnv
   │  │  ├─ git
   │  │  ├─ packages
   │  │  └─ zsh
   │  └─ desktop
   │     ├─ gaming
   │     │  └─ performance
   │     ├─ hyprland
   │     ├─ kde
   │     ├─ locale
   │     └─ login
   └─ home
      ├─ system
      │  ├─ hyprland
      │  ├─ networking
      │  └─ xdg
      ├─ cli
      │  ├─ eza
      │  ├─ git
      │  ├─ helix
      │  └─ zsh
      └─ desktop
         ├─ firefox
         ├─ gaming
         │  └─ openmw
         ├─ hyprland
         │  └─ services
         │     └─ hypridle
         ├─ launcher
         ├─ mpv
         ├─ wezterm
         └─ xdg
```

## Adding roots to prefetched sources
```
$ nix-store --add-fixed sha256 /path/to/source
/nix/store/hash-source
$ sudo nix-store --add-root /nix/var/nix/gcroots/pinned/source -r /nix/store/hash-source
```
