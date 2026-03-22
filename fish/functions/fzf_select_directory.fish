function fzf_select_directory
    # Search from home directory, not both . and ~
    set -l dir (fd -t d -H ~ 2>/dev/null | fzf --height=40% --reverse --border --preview 'ls -la {}')
    
    if test -n "$dir"
        # Insert the directory path at cursor position
        commandline -i "$dir"
        # Add a space after the path for convenience
        commandline -i " "
    end
    commandline -f repaint
end
