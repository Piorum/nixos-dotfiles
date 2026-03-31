{ config, pkgs, lib, ...}:
{
	home.username = "username";
	home.homeDirectory = "/home/username";
	home.stateVersion = "26.05";
	programs.kitty.enable = true;
	programs.lf.enable = true;
	programs.bash.enable = true;

	home.file.".config/fastfetch".source = ./config/fastfetch;
	home.file.".config/gtk-3.0".source = ./config/gtk-3.0;
	home.file.".config/htop".source = ./config/htop;
	home.file.".config/hypr".source = ./config/hypr;
	home.file.".config/kitty".source = ./config/kitty;
	home.file.".config/lf".source = ./config/lf;
	home.file.".config/mako".source = ./config/mako;
	home.file.".config/nvtop".source = ./config/nvtop;
	home.file.".config/tofi".source = ./config/tofi;
	home.file.".config/waybar".source = ./config/waybar;

	home.file.".local/share/applications/lm-studio.desktop".source = ./desktop/lm-studio.desktop;
	home.file.".local/share/applications/org.chromium.Chromium.desktop".source = ./desktop/org.chromium.Chromium.desktop;

	home.file.".scripts".source = ./scripts;
	home.file.".zprofile".source = ./zprofile;
	home.file.".zshrc".source = ./zshrc;
	home.file.".p10k.zsh".source = ./p10k.zsh;

}   
