# madeddie nix config for darwin-nix and nix-on-droid

These configs can be used to set up my Android terminal and MacOS machines.

## Steps to initialize on MacOS

1. install Nix or a derivative like
   [Determinate](https://docs.determinate.systems/) or
   [Lix](https://lix.systems/install/#on-any-other-linuxmacos-system)
2. `git clone git@github.com:madeddie/home-manager.git ~/.config/home-manager`
3. `sudo ln -s /Users/edwin/.config/home-manager/nix-darwin /etc/nix-darwin`
4. `nix run nix-darwin/master#darwin-rebuild -- switch`
5. `darwin-rebuild switch`

## Steps to initialize on Android

1. Install the termux forked UI https://f-droid.org/en/packages/com.termux.nix
2. `nix run nixpkgs\#git -- clone git@github.com:madeddie/home-manager.git ~/.config/home-manager`
3. `rm -rf ~/.config/nixpkgs`
4. `ln -s $(pwd)/nix-on-droid ~/.config/nixpkgs`
5. `nix-on-droid switch`

## Steps to initialize Home Manager

1.

        nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
        nix-channel --update

2. `nix run home-manager/master -- switch`
3. `home-manager switch`

## Other requirements

The nix-darwin setup installs packages using Homebrew, so it's good to have this
installed before starting:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
