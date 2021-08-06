$DOTFILES = "$HOME\.dotfiles"
$repo = "https://github.com/kamack38/dotfiles.git"

git clone -b base --bare $repo $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout