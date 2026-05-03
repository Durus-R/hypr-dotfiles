set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x SHELL /usr/bin/fish
set -xU MANROFFOPT "-c"

set -xU MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end


# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | string trim --right --chars=/)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Cleanup local orphaned packages
function cleanup
    while pacman -Qdtq
        sudo pacman -R (pacman -Qdtq)
        if test "$status" -eq 1
           break
        end
    end
    nix-collect-garbage -d
    docker image prune -af
end

## Useful aliases
# Replace ls with eza
alias ls 'eza -l --color=always --group-directories-first --icons' # preferred listing
alias lh 'eza -al --color=always --group-directories-first --icons' # preferred listing
alias lsz 'eza -al --color=always --total-size --group-directories-first --icons' # include file size
alias la 'eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll 'eza -l --color=always --group-directories-first --icons'  # long format
alias lt 'eza -aT --color=always --group-directories-first --icons' # tree listing
alias l. 'eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles

# Replace some more things with better alternatives
abbr cat 'bat --style header,snip,changes'
if not test -x /usr/bin/yay; and test -x /usr/bin/paru
    alias yay 'paru'
end

# Common use
alias .. 'cd ..'
alias ... 'cd ../..'
alias rip 'expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -200 | nl'
alias gdrive_reconnect 'rclone config reconnect gdrive:'
alias du 'erd --config du'
alias jctl 'journalctl -p 3 -xb'
alias tree 'erd'
alias erdh 'erd --hidden'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias big 'expac -H M "%m\t%n" | sort -h | nl'     # Sort installed packages according to size in MB (expac must be installed)
alias dir 'dir --color=auto'
alias fixpacman 'sudo rm /var/lib/pacman/db.lck'
alias gitpkg 'pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias grep 'ugrep --color=auto'
alias egrep 'ugrep -E --color=auto'
alias fgrep 'ugrep -F --color=auto'
alias grubup 'sudo update-grub'
alias hw 'hwinfo --short'                          # Hardware Info
alias ip 'ip -color'
alias psmem 'ps auxf | sort -nr -k 4'
alias psmem10 'ps auxf | sort -nr -k 4 | head -10'
alias rmpkg 'sudo pacman -Rdd'
alias tarnow 'tar -acf '
alias untar 'tar -zxvf '
alias upd '/usr/bin/garuda-update'
alias vdir 'vdir --color=auto'
alias wget 'wget -c '

# Get fastest mirrors
alias mirror 'sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist'
alias mirrora 'sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist'
alias mirrord 'sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist'
alias mirrors 'sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist'

alias taildrop 'sudo tailscale file get ~/Downloads'

# Fish command history
function history
    builtin history --show-time='%F %T '
end

set -x PARU_PAGER "less -P \"Press 'q' to exit the PKGBUILD review.\""

if status is-login
    if test (tty) = "/dev/tty1"
        exec start-hyprland
    end
end

starship init fish | source
if status is-interactive
# Commands to run in interactive sessions can go here
    if [ "$TERM" = "xterm-kitty" ]
        fastfetch -c archey.jsonc --logo ~/Bilder/icon.png --logo-height 20
        alias icat "kitty +kitten icat"
    else
        fastfetch -c archey.jsonc 
    end
end
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
alias l "erd --level 1"
function load_ssh
    dcli sync
    eval (ssh-agent -c)
    dcli note "SSH Privatekey" | ssh-add -
end

alias gpu_on "supergfxctl -m Hybrid && hyprshutdown -t 'Logout'"
alias gpu_off "supergfxctl -m Integrated && hyprshutdown -t 'Logout'"
set -x TS_EXITNODE de-fra-wg-101.mullvad.ts.net

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/kitten/.lmstudio/bin
# End of LM Studio CLI section

#set -gx PATH $PATH /home/kitten/go/bin
