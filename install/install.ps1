$DOTFILES = "$HOME\.dotfiles"
$repo = "https://github.com/kamack38/dotfiles.git"

git clone -b base --bare $repo $DOTFILES
dtf config --local status.showUntrackedFiles no
dtf checkout