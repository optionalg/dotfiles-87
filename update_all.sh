# Homebrew
brew update && brew upgrade && brew cleanup -s && brew prune && brew doctor
# Apple Store
mas upgrade
# Ruby
gem update
# LaTeX
tlmgr update --all
# Python
pip-review -a
# Neovim
nvim +PlugUpgrade +PlugUpdate +PlugClean +UpdateRemotePlugins +CheckHealth +qa
