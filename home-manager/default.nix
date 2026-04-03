{ homeManager, nixpkgs }:
{ modulesPath, pkgs, ... }:

let
  unstablePkgs = import nixpkgs {
    system = pkgs.system;
  };
in
{
  disabledModules = [
    (modulesPath + "/programs/opencode.nix")
  ];

  imports = [
    (homeManager + "/modules/programs/opencode.nix")
  ];

  programs.opencode = {
    enable = true;
    package = unstablePkgs.opencode;
    rules = ../opencode/AGENTS.md;
    skills = ../opencode/skills;
    settings = {
      default_agent = "plan";
      plugin = [
        "@slkiser/opencode-quota@latest"
        "superpowers@git+https://github.com/obra/superpowers.git"
      ];
      share = "disabled";
      autoupdate = true;
      model = "openai/gpt-5.4";
      small_model = "github-copilot/gpt-5-mini";
      disabled_providers = [ "opencode" ];
      agent = {
        plan = {
          color = "#1a7f37";
        };
        build = {
          color = "#d1242f";
        };
      };
      experimental = {
        quotaToast = {
          enabledProviders = [ "openai" "copilot" "zai" ];
        };
      };
    };
  };
}
