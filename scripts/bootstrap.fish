#!/usr/bin/fish
if [ ! -f ~/.gitconfig ]
    git config --global user.name "Stefan Küpper"
    git config --global user.email stefan.kuepper@posteo.de
    git config --global init.defaultBranch main
end
if [ ! -d ~/.rye ]
    curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes" bash

    fish -c 'set -Ua fish_user_paths "$HOME/.rye/shims"'
    if [ ! -d ~/.config/fish/completitions ]
        mkdir -p /home/stefan/.config/fish/completions/
    end
    rye self completion -s fish >~/.config/fish/completions/rye.fish

end

if [ ! -d ~/.ssh ]
    mkdir --mode 700 ~/.ssh
    cat /id_ed25519.pub >~/.ssh/authorized_keys
end
