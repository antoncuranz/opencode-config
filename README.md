# opencode-config

Reusable Home Manager config for OpenCode.

## What it manages

- `programs.opencode.settings`
- `programs.opencode.rules`
- `programs.opencode.commands`
- `programs.opencode.agents`
- `programs.opencode.skills`
- `programs.opencode.themes`

This writes OpenCode config into `~/.config/opencode`.

## Usage

Add this repo as a flake input and import its Home Manager module.

```nix
{
  inputs.opencode-config.url = "github:yourname/opencode-config";

  outputs = { self, nixpkgs, home-manager, opencode-config, ... }: {
    homeConfigurations.me = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "aarch64-darwin"; };
      modules = [
        opencode-config.homeManagerModules.default
      ];
    };
  };
}
```

## Secrets

Set required secrets outside this repo.

- `CONTEXT7_API_KEY`

OpenCode reads the MCP header from `{env:CONTEXT7_API_KEY}`.
