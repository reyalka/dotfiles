{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "reyalka";
  home.homeDirectory = "/home/reyalka";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;[
    # Shell
	bat
	fd
	fzf
	neovim
	ripgrep
    doppler
    eza
    gh
    hyperfine
    imagemagick
    jnv
    jq
    just
    lazygit
    ncdu
    scc
    tree
    unzip
    yazi
    zip

    # Node.js
	nodejs
    pnpm
    bun
    deno

    # Python
    python3

    # Nix
    nixd

    # Rust
    rustc
    cargo

    # C
    gcc
    gnumake
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
    
  programs = {
      direnv = {
          enable = true;
          nix-direnv.enable = true;
      };
      fzf = {
          enable = true;
      };
      fish = {
          enable = true; 
          interactiveShellInit = builtins.readFile ./config.fish;
          plugins = [
              {
                  name = "z";
                  src = pkgs.fishPlugins.z.src;
              }
              {
                  name = "autopair";
                  src = pkgs.fishPlugins.autopair.src;
              }
              {
                  name = "pure";
                  src = pkgs.fishPlugins.pure.src;
              }
          ];
      };
      uv = {
          enable = true;
      };
      git = {
          enable = true;
          userName = "reyalka";
          userEmail = "140703515+reyalka@users.noreply.github.com";
          extraConfig = {
              commit.gpgsign = true;
              push.autoSetupRemote = true;
              init.defaultBranch = "main";
              pull.rebase = true;
          };
          signing = {
              key = "9C5273A403A2CD19";
              signByDefault = true;
          };
          delta = {
              enable = true;
          };
      };
      gh = {
        enable = true;
        gitCredentialHelper = {
            enable = true;
        };
      };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/reyalka/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
