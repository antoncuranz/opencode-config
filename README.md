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

## Module source

This repo intentionally overrides Home Manager's bundled `programs.opencode` module.

The stable `release-25.11` module still lacks `programs.opencode.skills = <path>;`, which this repo uses.
`disabledModules` turns off the caller's bundled `programs/opencode.nix`, and `imports` loads the newer upstream one instead.

This flake exports modules only, so it does not need a separate root `nixpkgs` input.

## Secrets

Set required secrets outside this repo.

- `CONTEXT7_API_KEY`

OpenCode reads the MCP header from `{env:CONTEXT7_API_KEY}`.
