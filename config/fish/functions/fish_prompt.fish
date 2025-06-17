function fish_prompt --description 'Colorful fish prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_color (set_color blue)
    
    # Show last command status
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
    end
    
    # Current working directory
    set -l pwd_info (prompt_pwd)
    
    # Git information
    set -l git_info
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l branch_name (command git symbolic-ref --short HEAD 2>/dev/null; or command git rev-parse --short HEAD 2>/dev/null)
        set -l git_status (command git status --porcelain 2>/dev/null)
        
        if test -n "$git_status"
            set git_info "$vcs_color [$branch_name*]"
        else
            set git_info "$vcs_color [$branch_name]"
        end
    end
    
    # Show username@hostname for SSH sessions
    set -l user_host
    if test -n "$SSH_CLIENT" -o -n "$SSH_TTY"
        set user_host (set_color brgreen)(whoami)(set_color white)@(set_color brblue)(hostname)(set_color white)" "
    end
    
    # Time
    set -l time_info (set_color bryellow)(date '+%H:%M:%S')
    
    # Build prompt
    echo -n -s $time_info $normal ' ' $user_host $cwd_color $pwd_info $git_info $normal
    echo -e ""
    echo -n -s $status_color '❯ ' $normal
end
