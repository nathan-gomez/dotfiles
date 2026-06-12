function fish_user_key_bindings
    bind ctrl-l 'clear; commandline -f repaint'

    bind up history-prefix-search-backward
    bind ctrl-p history-prefix-search-backward

    bind down history-prefix-search-forward
    bind ctrl-n history-prefix-search-forward

    # Edit command line in $EDITOR
    bind alt-e edit_command_buffer
end
