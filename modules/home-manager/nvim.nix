{pkgs, ...}: {
  nvf = {
    enable = true;
    settings = {
      vim = {
        treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          regex
          kdl
          clang
        ];

        formatter = {
          conform-nvim = {
            enable = true;
            setupOpts = {
              formatters_by_ft = {
                kdl = ["kdlfmt"];
              };
            };
          };
        };

        lsp.enable = true;
        lsp.formatOnSave = true;

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        languages = {
          nix = {
            enable = true;
            format.enable = true;
          };
          clang = {
            enable = true;
            lsp.enable = true;
            cHeader = false;
            dap.enable = true;
          };
        };

        extraPlugins = {
          harpoon = {
            package = pkgs.vimPlugins.harpoon;
            setup = "require('harpoon').setup {}";
          };
        };
      };
    };
  };
}
