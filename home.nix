{ pkgs, ... }:

{

  # The home-manager manual is at:
  #
  #   https://rycee.gitlab.io/home-manager/release-notes.html
  #
  # Configuration options are documented at:
  #
  #   https://rycee.gitlab.io/home-manager/options.html

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  #
  # You need to change these to match your username and home directory
  # path:
  home.username = "louish";
  home.homeDirectory = "/home/louish";

  # If you use non-standard XDG locations, set these options to the
  # appropriate paths:
  #
  # xdg.cacheHome
  # xdg.configHome
  # xdg.dataHome

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.shellAliases = {
    ls = "eza";
    la = "eza -a";
    ll = "eza -la";
    rmm = "trash";
    rm = "rm -v";
    cp = "cp -iv";
    mv = "mv -iv";
    mkdir = "mkdir -pv";    
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Since we do not install home-manager, you need to let home-manager
  # manage your shell, otherwise it will not be able to add its hooks
  # to your profile.
  # programs.bash = {
  #   enable = true;
  # };

  home.packages = with pkgs; [
    # pkgs.htop
    # pkgs.fortune
	helix
	zellij
	alacritty
	git
	github-cli
  ifuse
  toybox
  iptables
  
  rustup

   # gcc
  # lldb
  # clang-tools
  # gnumake
  # cmake
  # gdb

  wimlib
  ventoy

  # tcsh
  gnome-keyring
  authenticator
  oath-toolkit
  

  qemu
  typst
  typst-lsp
  texliveFull
  ghostscript_headless
	
	# starship
	
	zathura
	spotify
  xournalpp
  joplin
  joplin-desktop
  libreoffice
  light
  brillo

  unzip
  zip
  p7zip
  imagemagick
  qpdf
  ocamlPackages.cpdf
	# exa
	# ripgrep
	# ripgrep-all
	fd
	sd
	du-dust
  procs
  tealdeer
  xclip

  trash-cli
  eza

  lf

  anki

  openconnect
  sshfs
  # toybox
  ];

  # ...other config, other config...

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };
  # Or any other shell you're using.program.direnv.enable = true;
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  

}
