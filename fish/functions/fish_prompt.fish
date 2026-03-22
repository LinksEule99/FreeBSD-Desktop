function fish_prompt
    # Vibrant OneDark colors (more saturated)
    set bracket_color "#e06c75"     # Vibrant red for brackets
    set user_color "#ff7a8c"        # Brighter, more vibrant red
    set at_color "#f5c86f"          # Brighter yellow
    set host_color "#f5c86f"        # Same vibrant yellow
    set colon_color "#b3e07c"       # Brighter green
    set dir_color "#b3e07c"         # Same vibrant green
    set dollar_color "#7ec8ff"      # Brighter blue
    
    # Build prompt with user@host in brackets
    echo -n -s (set_color $bracket_color)"["(set_color normal)
    echo -n -s (set_color $user_color)(whoami)(set_color normal)
    echo -n -s (set_color $at_color)"@"(set_color normal)
    echo -n -s (set_color $host_color)(hostname -s)(set_color normal)
    echo -n -s (set_color $bracket_color)"]"(set_color normal)
    echo -n -s (set_color $colon_color)":"(set_color normal)
    echo -n -s (set_color $dir_color)(prompt_pwd)(set_color normal)
    echo -n -s (set_color $dollar_color)'$ '(set_color normal)
end
