{ config, lib, ... }:

with lib;
let
  colorsConfiguration = {
    "3bit" = mkOption {
      type = types.str;
      default = "1";
      description = "Color used when terminal has only 3-bit coloring";
    };

    "8bit" = mkOption {
      type = types.str;
      default = "202";
      description = "Color used when terminal has only 8-bit coloring";
    };

    "24bit" = mkOption {
      type = types.str;
      default = "#17BEBB";
      description = "Color used when terminal has only 24-bit coloring";
    };
  };
in
{
  options.colors = mkOption {
    type = types.submodule { options = colorsConfiguration; };
    default = {};
    description = "Contains colors that will be used in terminal";
  };

  config = {
    initShellHook = ''
      if [[ $COLORTERM = "truecolor" ]] || [[ $COLORTERM = "24bit" ]]; then
        # We have 24-bit colors
        HEX_COLOR=${config.colors."24bit"}
        COLOR=$(printf "\e[38;2;%d;%d;%dm" 0x''${HEX_COLOR:1:2} 0x''${HEX_COLOR:3:2} 0x''${HEX_COLOR:5:2})
      else
        _colors=$(tput colors)
        if [[ "$_colors" = "256" ]]; then
          # We have 8-bit colors
          COLOR=$(printf "\e[38;5;%dm" ${config.colors."8bit"})
        elif [[ "$_colors" = "8" ]] || [[ "$_colors" = "16" ]]; then
          # We have 3/4-bit colors
          COLOR=$(printf "\e[3%dm" ${config.colors."3bit"})
        fi
      fi
    '';
  };
}
