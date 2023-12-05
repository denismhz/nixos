{ config, pkgs, lib, ... }:
let
  lua = builtins.concatStringsSep "\n" (builtins.map builtins.readFile (lib.filesystem.listFilesRecursive ./lua));
in
{
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  coc.enable = true;
  coc.settings = {
    "languageserver" = {
      "nixd" = {
        "command" = "nixd";
        "rootPatterns" = [ ".nixd.json" ];
        "filetypes" = [ "nix" ];
      };
    };
  };

  extraConfig =
    ''
      set expandtab tabstop=2 shiftwidth=2
      " set clipboard+=unnamedplus
      set relativenumber number
      set title
      nnoremap <C-n> :Neotree<CR>
    '';

  extraLuaConfig =
    ''
      ${lua}
    '';

  plugins = with pkgs.vimPlugins; [
    telescope-nvim #not working but why 
    neo-tree-nvim
    nvim-web-devicons
    nvim-lspconfig
    {
      plugin = dracula-nvim;
      #config = builtins.readFile ./lua/theme.lua;
    }
    nvim-treesitter.withAllGrammars
    bufferline-nvim
  ];
}
