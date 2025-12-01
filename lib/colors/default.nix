# NOTE: maybe replace base16 with own implementation https://github.com/mxxntype/Aeon-snowfall
# TODO: configure `ov`, `tealdeer`, `eza` (https://github.com/eza-community/eza/blob/main/docs/theme.yml), `gitui`
# https://tinted-theming.github.io/tinted-gallery/

{
  lib,
  inputs,
  ...
}:
let
  inherit (inputs.nix-math.lib) math;
in
rec {
  color = rec {
    # hex2rgb :: string -> [float; 3]
    # arguments:
    #   hex: hex color string to be converted
    # Converts a hex color (e.g "#ff0000") to [r g b] floats in [0.0, 1.0]
    hex2rgb =
      hex:
      assert lib.assertMsg (builtins.isString hex) "hex2rgb :: string -> [float; 3]";
      assert lib.assertMsg (
        builtins.match "^#[0-9a-fA-F]{6}$" hex != null
      ) "`hex` must be a valid hex color";
      let
        toFloat =
          idx:
          let
            sub = builtins.substring idx 2 (lib.removePrefix "#" hex);
          in
          (builtins.fromTOML "v = 0x${sub}").v / 255.0;
      in
      map toFloat [
        0
        2
        4
      ];

    # rgb2hex :: [float; 3] -> string
    # arguments:
    #   rgb: list of RGB values to be converted
    # Converts [r g b] floats in [0.0, 1.0] to a hex color string (e.g. "#ff0000")
    rgb2hex =
      rgb:
      assert lib.assertMsg (
        builtins.isList rgb && builtins.all builtins.isFloat rgb && builtins.length rgb == 3
      ) "rgb2hex :: [float; 3] -> string";
      let
        hexChars = lib.stringToCharacters "0123456789abcdef";
        toHex =
          col:
          let
            val = lib.gravelOS.clamp (math.round (col * 255.0)) 0 255;
          in
          (lib.elemAt hexChars (val / 16)) + (lib.elemAt hexChars (math.mod val 16));
      in
      "#" + lib.concatStrings (map toHex rgb);

    # srgb2linear :: [float; 3] -> [float; 3]
    # arguments:
    #   srgb: list of sRGB values to be converted
    # Converts a list of sRGB values in [0.0, 1.0] to linear RGB
    srgb2linear =
      srgb:
      assert lib.assertMsg (
        builtins.isList srgb && builtins.all builtins.isFloat srgb && builtins.length srgb == 3
      ) "srgb2linear :: [float; 3] -> [float; 3]";
      let
        toLinear = col: if col <= 0.04045 then col / 12.92 else math.pow ((col + 0.055) / 1.055) 2.4;
      in
      map toLinear srgb;

    # linear2srgb :: [float; 3] -> [float; 3]
    # arguments:
    #   linear: list of linear RGB values to be converted
    # Converts a list of linear RGB values in [0.0, 1.0] to sRGB
    linear2srgb =
      linear:
      assert lib.assertMsg (
        builtins.isList linear && builtins.all builtins.isFloat linear && builtins.length linear == 3
      ) "srgb2linear :: [float; 3] -> [float; 3]";
      let
        toSrgb = col: if col <= 0.0031308 then 12.92 * col else 1.055 * (math.pow col (1 / 2.4)) - 0.055;
      in
      map toSrgb linear;

    # rgb2xyz :: [float; 3] -> [float; 3]
    # arguments:
    #   rgb: list of sRGB values to be converted
    # Converts a list of sRGB values in [0.0, 1.0] to CIE XYZ color space
    rgb2xyz =
      rgb:
      assert lib.assertMsg (
        builtins.isList rgb && builtins.all builtins.isFloat rgb && builtins.length rgb == 3
      ) "rgb2xyz :: [float; 3] -> [float; 3]";
      let
        linear = srgb2linear rgb;
        r = builtins.elemAt linear 0;
        g = builtins.elemAt linear 1;
        b = builtins.elemAt linear 2;
      in
      [
        (0.4124564 * r + 0.3575761 * g + 0.1804375 * b)
        (0.2126729 * r + 0.7151522 * g + 0.0721750 * b)
        (0.0193339 * r + 0.1191920 * g + 0.9503041 * b)
      ];

    # xyz2rgb :: [float; 3] -> [float; 3]
    # arguments:
    #   xyz: list of XYZ values to be converted
    # Converts a list of CIE XYZ values to sRGB in [0.0, 1.0]
    xyz2rgb =
      xyz:
      assert lib.assertMsg (
        builtins.isList xyz && builtins.all builtins.isFloat xyz && builtins.length xyz == 3
      ) "xyz2rgb :: [float; 3] -> [float; 3]";
      let
        x = builtins.elemAt xyz 0;
        y = builtins.elemAt xyz 1;
        z = builtins.elemAt xyz 2;
        linear = [
          (3.2404542 * x - 1.5371385 * y - 0.4985314 * z)
          (-0.9692660 * x + 1.8760108 * y + 0.0415560 * z)
          (0.0556434 * x - 0.2040259 * y + 1.0572252 * z)
        ];
      in
      linear2srgb linear;

    lab =
      let
        D65_WHITE_POINT = [
          0.95047
          1.0
          1.08883
        ];
        LAB_EPSILON = 0.008856;
        LAB_KAPPA = 903.3;
      in
      rec {
        # xyz2lab :: [float; 3] -> [float; 3]
        # arguments:
        #   xyz: list of XYZ values to be converted
        # Converts a list of CIE XYZ values to CIE L*a*b* color space
        xyz2lab =
          xyz:
          assert lib.assertMsg (
            builtins.isList xyz && builtins.all builtins.isFloat xyz && builtins.length xyz == 3
          ) "xyz2lab :: [float; 3] -> [float; 3]";
          let
            toLab = val: if val > LAB_EPSILON then math.pow val (1.0 / 3.0) else (LAB_KAPPA * val + 16) / 116.0;
            x = toLab (builtins.elemAt xyz 0 / builtins.elemAt D65_WHITE_POINT 0);
            y = toLab (builtins.elemAt xyz 1 / builtins.elemAt D65_WHITE_POINT 1);
            z = toLab (builtins.elemAt xyz 2 / builtins.elemAt D65_WHITE_POINT 2);
          in
          [
            (116 * y - 16)
            (500 * (x - y))
            (200 * (y - z))
          ];

        # lab2xyz :: [float; 3] -> [float; 3]
        # arguments:
        #   lab: list of L*a*b* values to be converted
        # Converts a list of CIE L*a*b* values to CIE XYZ color space
        lab2xyz =
          lab:
          assert lib.assertMsg (
            builtins.isList lab && builtins.all builtins.isFloat lab && builtins.length lab == 3
          ) "lab2xyz :: [float; 3] -> [float; 3]";
          let
            toXYZ =
              val:
              let
                val3 = math.pow val 3.0;
              in
              if val3 > LAB_EPSILON then val3 else (116 * val - 16) / LAB_KAPPA;

            fy = (builtins.elemAt lab 0 + 16) / 116.0;
            fx = fy + (builtins.elemAt lab 1 / 500.0);
            fz = fy - (builtins.elemAt lab 2 / 200.0);

            x = builtins.elemAt D65_WHITE_POINT 0 * toXYZ fx;
            y = builtins.elemAt D65_WHITE_POINT 1 * toXYZ fy;
            z = builtins.elemAt D65_WHITE_POINT 2 * toXYZ fz;
          in
          [
            x
            y
            z
          ];

        # hex2lab :: string -> [float; 3]
        # arguments:
        #   hex: hex color string to be converted
        # Converts a hex color (e.g "#ff0000") to CIE L*A*B color space
        hex2lab = hex: xyz2lab (rgb2xyz (hex2rgb hex));

        # lab2hex :: [float; 3] -> string
        # arguments:
        #   lab: list of L*a*b values to be converted
        # Converts a list of CIE L*A*B values to a hex color string
        lab2hex = lab: rgb2hex (xyz2rgb (lab2xyz lab));
      };
  };
}
