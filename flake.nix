{
  description = "Reusable Home Manager config for OpenCode";

  inputs = {
    homeManager = {
      url = "github:nix-community/home-manager/master";
    };
  };

  outputs = { self, homeManager, ... }: {
    homeManagerModules.default = import ./home-manager { inherit homeManager; };
    homeManagerModules.opencode = self.homeManagerModules.default;
  };
}
