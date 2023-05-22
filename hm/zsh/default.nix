{ config, lib, pkgs, user, ... }:

{
  programs.zsh = {
    enable = true;
    # loginShellInit = ''
    #   # set TTY1 (tty)
    #   # [ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session sway --unsupported-gpu
    #    set TTY1 (tty)
    #    [ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session Hyprland
    # '';
    enableCompletion = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "zsh-users/zsh-syntax-highlighting"; } # Simple plugin installation
      ];
    };
    history = {
      size = 10000;
    };
    initExtra = ''
      [[ ! -f ~/.aliases ]] || source ~/.aliases
     
      # Disable flow control (ctrl+s, ctrl+q) to enable saving with ctrl+s in Vim
      stty -ixon -ixoff
      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh)"
    '';
  };
  home.file.".aliases".source = ./aliases;
  home.file.".config/bindkey.zsh".source = ./bindkey.zsh;
}
