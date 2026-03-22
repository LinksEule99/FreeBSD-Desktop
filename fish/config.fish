if status is-interactive
    # Remove the welcome message
    set fish_greeting
    
    # Add local bin to PATH
    set -gx PATH $HOME/.local/bin $PATH
    
    # Replace ls with eza (preserve original ls with command ls if needed)
    alias ls='eza -la --icons'
    alias l='eza -la --icons'
    alias ll='eza -l --icons'
    
    # Alt+C to fzf and paste path (files and directories)
    bind \ec 'fzf_path_picker'
end
