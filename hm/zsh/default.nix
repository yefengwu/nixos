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
    shellAliases = {
      ps = "ps aux";
      bat = "batcat";
      vd = "nvim -d";
      ll = "ls -alh";
      l = "ls -lah";
      la = "ls -al";
      lg = "lazygit";
      ls = "ls --color=tty";
      lsa = "ls -lah";
      md = "mkdir -p";
      sp = "sudo apt update && sudo apt upgrade -y";
      ra = "ranger";
      afind = "ack -il";
      d = "dirs -v | head -10";
      z = "__zoxide_z";
      zi = "__zoxide_zi";

      # git-aliases
      gcl = "git clone";
      gst = "git status";
      gd = "git diff HEAD";

      #docker-alias;
      ds = "docker ps -a --format 'table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}'";
      di = "docker images";
      da = "docker attach";
      de = "function(){ docker exec -it '$1' /bin/sh }";

      # nixos 
      nsf = "sudo nixos-rebuild switch --flake .#laptop";
      ntf = "sudo nixos-rebuild test --flake .#laptop";
      nsl = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      ngd = "sudo nix-collect-garbage -d";
      ndg = "sudo nix-delete-generations -d";
    };
    history = {
      size = 10000;
    };
    initExtra = ''
      [[ ! -f ~/.aliases ]] || source ~/.aliases
      # Standard and additional keybindings
      #
      # Find the key with: showkey -a
      #
      #   ctrl + u     : clear line
      #   ctrl + w     : delete word backward
      #   alt  + d     : delete word
      #   ctrl + a     : move to beginning of line
      #   ctrl + e     : move to end of line (e for end)
      #   alt/ctrl + f : move to next word (f for forward)
      #   alt/ctrl + b : move to previous word (b for backward)
      #   ctrl + d     : delete char at current position (d for delete)
      #   ctrl + k     : delete from character to end of line
      #   alt  + .     : cycle through previous args
      
      # Emacs style bindings (for Home/End keys...)
      bindkey -e
      
      # In menu completion, the Return key will accept the current selected match
      # bindkey -M menuselect '^M' .accept-line
      
      # shift-tab : go backward in menu (invert of tab
      bindkey '^[[Z' reverse-menu-complete
      
      # alt-x : insert last command result
      zmodload -i zsh/parameter
      insert-last-command-output() {
        LBUFFER+="$(eval $history[$((HISTCMD-1))])"
      }
      zle -N insert-last-command-output
      bindkey '^[x' insert-last-command-output
      
      # ctrl+b/f or ctrl+left/right : move word by word (backward/forward)
      bindkey '^b' backward-word
      # bindkey '^f' forward-word
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
      bindkey '^H' backward-kill-word
      bindkey '^[[3;5~' kill-word
      bindkey '^[[3~' delete-char
      bindkey '^?' backward-delete-char
      
      # Alt+~: run Git WTF script
      function _git_wtf {
        echo
        git-wtf
        zle reset-prompt
      }
      zle -N _git_wtf
      bindkey '^[`' _git_wtf
      
      # Execute the current suggestion (using zsh-autosuggestions)
      # Alt+Enter = '^[^M' on recent VTE and '^[^J' for older (Lxterminal)
      bindkey '^[^M' autosuggest-execute
      bindkey '^[^J' autosuggest-execute
      
      # Disable the capslock key and map it to escape
      # setxkbmap -option caps:backspace
      
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
}
