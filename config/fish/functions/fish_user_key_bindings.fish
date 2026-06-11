function fish_user_key_bindings
    bind -M insert ctrl-l 'clear; commandline -f repaint'
    bind -M default ctrl-l 'clear; commandline -f repaint'

    # Up / Ctrl+p: history search backward by typed prefix
    bind -M insert up history-prefix-search-backward
    bind -M insert ctrl-p history-prefix-search-backward
    bind -M default up history-prefix-search-backward
    bind -M default ctrl-p history-prefix-search-backward

    # Down / Ctrl+n: history search forward by typed prefix
    bind -M insert down history-prefix-search-forward
    bind -M insert ctrl-n history-prefix-search-forward
    bind -M default down history-prefix-search-forward
    bind -M default ctrl-n history-prefix-search-forward

    # Edit command line in $EDITOR
    bind -M insert alt-e edit_command_buffer
    bind -M default alt-e edit_command_buffer
end
