{
  description = "Reusable Home Manager config for OpenCode";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    homeManager = {
      url = "github:nix-community/home-manager/master";
    };
  };

  outputs = { self, homeManager, nixpkgs, ... }: {
    homeManagerModules.default = import ./home-manager { inherit homeManager nixpkgs; };
    homeManagerModules.opencode = self.homeManagerModules.default;
  };
}
