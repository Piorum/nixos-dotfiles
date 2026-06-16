{
	description = "Hyprland NixOS";
	
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }: {
		nixosConfigurations.starfall = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					#Temp remove when fixed
					#nixpkgs.overlays = [
					#	(final: prev: {
					#		openldap = prev.openldap.overrideAttrs (oldAttrs: {
					#			doCheck = false;
					#		});
					#	})
					#];
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.username = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
	};
}
