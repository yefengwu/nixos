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
    history = {
      size = 10000;
    };
    initExtra = ''
      ### Added by Zinit's installer
      if [ ! -f $HOME/.zinit/bin/zinit.zsh ]; then
         command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
         command git clone https://github.com/zdharma-continuum/zinit.git "$HOME/.zinit/bin"
      fi

      source $HOME/.zinit/bin/zinit.zsh

      ### End of Zinit's installer chunk
      zinit light zsh-users/zsh-syntax-highlighting
      zinit light zsh-users/zsh-autosuggestions
      zinit light zsh-users/zsh-completions
      bindkey ',' autosuggest-accept

      [[ ! -f ~/.aliases ]] || source ~/.aliases
      [[ ! -f ~/.config/bindkey.zsh ]] || source ~/.config/bindkey.zsh
       
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