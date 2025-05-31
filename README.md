# GravelOS

<p align="center">
   <img src="https://upload.wikimedia.org/wikipedia/commons/a/ad/SoilTexture_USDA.svg" alt="A soil texture diagram" width="503" height="480"/>
</p>

```
.
└─ modules
   ├─ nixos
   │  ├─ system
   │  │  ├─ boot
   │  │  ├─ networking
   │  │  ├─ audio
   │  │  ├─ login
   │  │  │  └─ user
   │  │  └─ locale
   │  ├─ cli
   │  │  ├─ packages
   │  │  ├─ devEnv
   │  │  ├─ zsh
   │  │  ├─ git
   │  │  └─ nh
   │  └─ desktop
   │     ├─ hyprland
   │     ├─ kde
   │     ├─ locale
   │     └─ gaming
   │        └─ performance
   └─ home
      ├─ system
      ├─ cli
      └─ desktop
```

## Adding roots to prefetched sources
```
$ nix-store --add-fixed sha256 /path/to/source
/nix/store/hash-source
$ sudo nix-store --add-root /nix/var/nix/gcroots/pinned/source -r /nix/store/hash-source
```
