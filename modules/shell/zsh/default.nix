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

      ### get special sub dir or file of github
      export PATH=$PATH:$HOME/.local/bin

      # set hostname env to use make rebuild system
      export HOSTNAME=$(hostname)

      ### End of Zinit's installer chunk
      zinit light zsh-users/zsh-syntax-highlighting
      zinit light zsh-users/zsh-autosuggestions
      zinit light zsh-users/zsh-completions
      bindkey ',' autosuggest-accept

      [[ ! -f ~/.aliases ]] || source ~/.aliases
      [[ ! -f ~/.config/bindkey.zsh ]] || source ~/.config/bindkey.zsh

      # tmux start
      # if [[ -z "$TMUX" ]] ;then
      #     ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
      #     if [[ -z "$ID" ]] ;then # if not available create a new one
      #         tmux new-session
      #     else
      #         tmux attach-session -t "$ID" # if available attach to it
      #     fi
      # fi
       
      # Disable flow control (ctrl+s, ctrl+q) to enable saving with ctrl+s in Vim
      stty -ixon -ixoff
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh)"
    '';
  };
  home.file.".aliases".source = ./aliases;
  home.file.".config/bindkey.zsh".source = ./bindkey.zsh;
}
