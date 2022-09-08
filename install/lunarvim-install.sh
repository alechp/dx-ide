#!/bin/sh

gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Install $(gum style --foreground 180 LunarVim) (https://lunarvim.org)"

echo "Which version of LunarVim would you like to install?"
VERSION=$(gum choose "stable" "rolling")

echo "Install neovim?"
NEOVIM_INSTALL=$(gum choose "yes" "no")
if [[ $NEOVIM_INSTALL == "yes" ]]; then
  # Install neovim
  bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
fi

echo "Install rustup?"
RUSTUP_INSTALL=$(gum choose "yes" "no")
if [[ $RUSTUP_INSTALL == "yes" ]]; then
  # Install Rustup
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "Install nodejs and npm?"
NODE_INSTALL=$(gum choose "yes" "no")
if [[ $NODE_INSTALL == "yes" ]]; then
  # Install nodejs
  sudo apt-get install nodejs npm
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
  echo "export PATH=~/.npm-global/bin:$PATH" > ~/.profile
  source ~/.profile
fi

echo "Are you installing on an ARM processor?"
PROCESSOR=$(gum choose "yes" "no")

if [[ $PROCESSOR == "yes" ]]; then
  # Some dependencies don't work using standard lunarvim install process on ARM processors (eg. tree-sitter-cli). Currently a failed install will halt the entire script. Installing manually for ARM
  # Install tree-sitter manually
  cargo install tree-sitter-cli

  # stable install...
  # https://stackoverflow.com/questions/3804577/have-bash-script-answer-interactive-prompts
  # rolling install...

else
  echo "Installing $VERSION LunarVim"
  if [[ $VERSION == "stable" ]]; then
    bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) 
  else 
    LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
  fi
  echo "Install other"
fi

echo "Configure abz's bloated lvim?"
BLOATED_INSTALL=$(gum choose "yes" "no")
if [[ $BLOATED_INSTALL == "yes" ]]; then
  mv ~/.config/lvim ~/.config/lvim_backup
  git clone https://github.com/abzcoding/lvim.git ~/.config/lvim
  lvim +LvimUpdate +LvimCacheReset +q
  lvim # run :PackerSync
fi
# Install neovim from source
  # install build prerequisites for neovim
  # sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
  # install neovim
  # cd ~/Code && git clone https://github.com/neovim/neovim
  # cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
  # sudo make install

# References
# TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
# SCOPE=$(gum input --placeholder "scope")

# # Since the scope is optional, wrap it in parentheses if it has a value.
# test -n "$SCOPE" && SCOPE="($SCOPE)"

# # Pre-populate the input with the type(scope): so that the user may change it
# SUMMARY=$(gum input --value "$TYPE$SCOPE: " --placeholder "Summary of this change")
# DESCRIPTION=$(gum write --placeholder "Details of this change (CTRL+D to finish)")

# # Commit these changes
# gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"


# echo "Are you installing LunarVim on an ARM processor (eg. Raspberry Pi)? (Y/n)"
# read isarm

# if [[ "$isarm" = "y" || "$isarm" = "ye" || "$isarm" = "yes"  || "$isarm" = "Y" || "$isarm" = "Yes" || "$isarm" = "YEs" || "$isarm" = "YES"]]; then
#   echo "ye"
# else
#   echo "nah"
# fi
