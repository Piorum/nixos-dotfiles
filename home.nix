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

	home.file.".local/share/applications/org.chromium.Chromium.desktop".source = ./desktop/org.chromium.Chromium.desktop;

	home.file.".scripts".source = ./scripts;
	home.file.".zprofile".source = ./zprofile;
	home.file.".zshrc".source = ./zshrc;
	home.file.".p10k.zsh".source = ./p10k.zsh;

	home.activation.copyZenTheme = ''
		dir=$(find "$HOME/.var/app/app.zen_browser.zen/.zen" -maxdepth 1 -type d -name '*.Default*' | head -n1)
		if [ -n "$dir" ]; then
			mkdir -p "$dir/chrome"
			src1=${./userChrome.css}
			src2=${./userContent.css}
			dst1="$dir/chrome/userChrome.css"
			dst2="$dir/chrome/userContent.css"

			# If a file exists but is not writable try to fix ownership or perms, else remove it.
			for f in "$dst1" "$dst2"; do
				if [ -e "$f" ] && [ ! -w "$f" ]; then
					# try to make writable for current user
					chmod u+w "$f" 2>/dev/null || \
					chown "$(id -u):$(id -g)" "$f" 2>/dev/null || \
					rm -f "$f"
				fi
			done

			# Install with explicit mode (creates or replaces)
			install -m 0644 "$src1" "$dst1"
			install -m 0644 "$src2" "$dst2"
		fi
	'';

}   
