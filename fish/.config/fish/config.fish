if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting #remove welcome msg

fish_vi_key_bindings
bind -M insert -m default jk cancel repaint-mode
set -g fish_sequence_key_delay_ms 200

# source ~/.profile

# fish_add_path ~/.zvm/self/
# fish_add_path ~/.zvm/bin/

fish_add_path ~/.local/bin/
# fish_add_path $HOME/.nix-profile/bin/
# fish_add_path $HOME/.nix-profile/bin

set -gx EDITOR hx

bind \ef yazi

function batdiff
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
end

function fish_right_prompt
    echo (set_color 555555) $(whoami)
end

function fish_prompt
    # echo (set_color red) $PWD '>'
    # string join '' -- (set_color cyan) (prompt_pwd) ' '
    # string join '' -- (set_color cyan) (prompt_pwd) '❭❭ '
    # string join '' -- (set_color cyan) (prompt_pwd) '❯ '
    # string join '' -- (set_color cyan) (prompt_pwd) (set_color yellow) (fish_git_prompt) (set_color cyan)' '(set_color normal)
    string join '' -- (set_color cyan) (prompt_pwd) (set_color yellow) (fish_git_prompt) (set_color cyan)'> '(set_color normal)
end

# set tmux_status $(tmux has-session >/dev/null | echo nope)

# if string match -q "*nope" "$tmux_status"
#     echo $tmux_status
# end


## taking notes
set docs "$HOME/Documents"

function notes
    cd $docs/notes
    hx .
end

function journals
    cd $docs/journals
    hx .
end
# zoxide init --cmd cd fish | source
zoxide init fish | source

# Source .fex.fish if it's present
[ -f ~/.fex.fish ] && source ~/.fex.fish

alias fex $HOME/.fex/bin/fex

# bind --mode insert \cf fex

# bind --mode insert \cf xplr
# bind --mode insert \cf yazi

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# bind --mode insert \cf f

bind --mode insert \cz zellij

bind --mode insert \cp xplr

bind --mode insert \cr "source ~/.config/fish/config.fish && echo 'sourced config'"
