# Fish Shell Configuration

# Remove greeting
set fish_greeting

# Environment variables
set -gx EDITOR nano
set -gx BROWSER firefox
set -gx TERM kitty

# Add paths
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

# Aliases
alias ll 'ls -alF'
alias la 'ls -A'
alias l 'ls -CF'
alias ls 'ls --color=auto'
alias grep 'grep --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'
alias ..  'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# System aliases
alias df 'df -h'
alias du 'du -h'
alias free 'free -h'
alias ps 'ps aux'
alias psg 'ps aux | grep'
alias myip 'curl -s ipinfo.io/ip'
alias weather 'curl wttr.in'

# Git aliases
alias g 'git'
alias ga 'git add'
alias gc 'git commit'
alias gco 'git checkout'
alias gd 'git diff'
alias gl 'git log --oneline'
alias gp 'git push'
alias gs 'git status'
alias gpl 'git pull'

# Package management aliases
alias pac 'sudo pacman'
alias pacs 'sudo pacman -S'
alias pacr 'sudo pacman -R'
alias pacu 'sudo pacman -Syu'
alias pacss 'pacman -Ss'
alias yay 'yay --color=auto'

# System monitoring
alias htop 'btop'
alias top 'btop'
alias sys 'fastfetch'

# Directory navigation
alias home 'cd ~'
alias root 'cd /'
alias dtop 'cd ~/Desktop'
alias ddoc 'cd ~/Documents'
alias ddl 'cd ~/Downloads'

# File operations
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'
alias mkdir 'mkdir -pv'

# Archive extraction function
function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Quick directory creation and navigation
function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

# Quick find function
function ff
    find . -name "*$argv[1]*"
end

# History search
function hs
    history | grep $argv[1]
end

# Process search and kill
function pskill
    ps aux | grep $argv[1] | grep -v grep | awk '{print $2}' | xargs kill -9
end

# Weather function
function weather
    if test (count $argv) -eq 0
        curl -s "wttr.in/?format=3"
    else
        curl -s "wttr.in/$argv[1]?format=3"
    end
end

# System info
function sysinfo
    echo "System Information:"
    echo "=================="
    fastfetch
end

# Cleanup function
function cleanup
    echo "Cleaning package cache..."
    sudo pacman -Scc --noconfirm
    echo "Cleaning orphaned packages..."
    sudo pacman -Rns (pacman -Qtdq) 2>/dev/null
    echo "Cleanup complete!"
end

# Color support
set -gx CLICOLOR 1
set -gx LSCOLORS ExFxCxDxBxegedabagacad

# Fish syntax highlighting colors
set fish_color_normal normal
set fish_color_command 6CB6EB
set fish_color_keyword DA70D6
set fish_color_quote C9A96E
set fish_color_redirection BF616A
set fish_color_end 6CB6EB
set fish_color_error FF6B6B
set fish_color_param 4EC9B0
set fish_color_selection white --bold --background=brblack
set fish_color_search_match bryellow --background=brblack
set fish_color_history_current --bold
set fish_color_operator 6CB6EB
set fish_color_escape 6CB6EB
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_valid_path --underline
set fish_color_autosuggestion 555
set fish_color_user brgreen
set fish_color_host normal
set fish_color_cancel -r
set fish_pager_color_completion normal
set fish_pager_color_description B3A06D yellow
set fish_pager_color_prefix white --bold --underline
set fish_pager_color_progress brwhite --background=cyan

# Vi mode
fish_vi_key_bindings

# Startup message
if status is-interactive
    echo -e "\n🐠 Welcome to Fish Shell on Hyprland! 🏔️\n"
    echo "Type 'sys' for system info, 'cleanup' to clean system"
    echo "Use 'extract <file>' to extract archives"
    echo ""
end
