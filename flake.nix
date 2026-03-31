{
  description = "Reusable Home Manager config for OpenCode";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }: {
    homeManagerModules.default = import ./home-manager;
    homeManagerModules.opencode = self.homeManagerModules.default;
  };
}
