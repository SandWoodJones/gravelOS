{ ... }: _: prev: {
  # TODO:
  #     https://github.com/NixOS/nixpkgs/issues/380429
  #     https://github.com/NixOS/nixpkgs/pull/380991
  vesktop = prev.vesktop.override { electron = prev.electron_33; };
}
