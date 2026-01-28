_: {
  programs.fish.functions.add-fixed =
  #fish
  ''
    set store_path (nix-store --add-fixed sha256 $argv[1])
    sudo mkdir -p /nix/var/nix/gcroots/pinned
    sudo nix-store --add-root /nix/var/nix/gcroots/pinned/(basename $store_path) --realise $store_path
  '';
}
