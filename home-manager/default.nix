{ pkgs, ... }:

let
  jsonFormat = pkgs.formats.json { };

  settings = {
      default_agent = "plan";
      plugin = [
        "@slkiser/opencode-quota@latest"
        "superpowers@git+https://github.com/obra/superpowers.git"
      ];
      share = "disabled";
      autoupdate = true;
      model = "openai/gpt-5.4";
      small_model = "serverton/gpt-4.1";
      disabled_providers = [ "opencode" "vercel" ];
      provider = {
        serverton = {
          npm = "@ai-sdk/openai-compatible";
          name = "Serverton";
          options = {
            baseURL = "https://aikeys.serverton.de/v1";
          };
          models = {
            "gemini-3-pro-preview" = {
              name = "Google Gemini 3 Pro";
            };
            "copilot/claude-sonnet-4-5" = {
              name = "Claude Sonnet 4.5 (Copilot)";
            };
            "glm-4.6" = {
              name = "Z.AI GLM 4.6";
            };
            "glm-4.7" = {
              name = "Z.AI GLM 4.7";
            };
            "kimi-k2" = {
              name = "Kimi K2";
              options = {
                reasoningEffort = "high";
              };
            };
            "gpt-4.1" = {
              name = "OpenAI GPT 4.1";
            };
          };
        };
      };
      mcp = {
        playwright = {
          type = "local";
          command = [ "npx" "@playwright/mcp@latest" ];
          enabled = false;
        };
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
          headers = {
            CONTEXT7_API_KEY = "{env:CONTEXT7_API_KEY}";
          };
          enabled = true;
        };
      };
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
in
{
  programs.opencode = {
    enable = true;
    rules = ../opencode/AGENTS.md;
  };

  xdg.configFile = {
    "opencode/opencode.json" = {
      source = jsonFormat.generate "opencode.json" ({
        "$schema" = "https://opencode.ai/config.json";
      } // settings);
    };

    "opencode/skills" = {
      source = ../opencode/skills;
      recursive = true;
    };
  };
}
