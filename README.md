# DX-IDE
Ansible playbook to install:
- neovim
- lunarvim
- bloated lvim


## Neovim
Install neovim from source so it's ARM compatible
> https://github.com/neovim/neovim/wiki/Building-Neovim

1. Build prerequisites
```
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
```

2. Clone
> `cd ~/Code && git clone https://github.com/neovim/neovim`

3. Make neovim
> `cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo`

4. Install
> sudo make install

## Lunarvim
Execute vanilla script:
> https://stackoverflow.com/questions/21160776/how-to-execute-a-shell-script-on-a-remote-server-using-ansible


1. Install nodejs & npm
`sudo apt-get install nodejs npm`

2. Fix global permissions for NPM
> https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally


```
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo "export PATH=~/.npm-global/bin:$PATH" > ~/.profile
source ~/.profile
```

3. Install lunarvim
- Rustup install
> `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

- Install tree-sitter-manually
> https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md
> `cargo install tree-sitter-cli`
> NOTE: Trying to manually install tree-sitter-cli with NPM will still fail; have to use cargo which means that the NPM step will fail

```
LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
```

## Bloated Lvim
```
mv ~/.config/lvim ~/.config/lvim_backup
git clone https://github.com/abzcoding/lvim.git ~/.config/lvim
lvim +LvimUpdate +LvimCacheReset +q
lvim # run :PackerSync
```
