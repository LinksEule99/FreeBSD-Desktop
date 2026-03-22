function fzf_path_picker
    # Use fzf's built-in file walker to find files and directories
    # --walker-root starts from home directory
    # --walker file,dir includes both files and directories
    set -l selected (fzf --walker-root=$HOME --walker file,dir --height=40% --reverse --border --prompt="Path: ")
    
    if test -n "$selected"
        # Insert the selected path at cursor
        commandline -i "$selected"
        # Add a space after for convenience
        commandline -i " "
        commandline -f repaint
    end
end
