{ config, pkgs, ... }:

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
      "clangd" = {
        "command" = "clangd";
        "rootPatterns" = [ "compile_flags.txt" "compile_commands.json" ];
        "filetypes" = [ "c" "cc" "cpp" "c++" "objc" "objcpp" ];
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
      ${builtins.readFile ./theme.lua}
      ${builtins.readFile ./treesitter.lua}
      ${builtins.readFile ./web-devicons.lua}
      ${builtins.readFile ./coc.lua}
      ${builtins.readFile ./neotree.lua}
    '';

  plugins = with pkgs.vimPlugins; [
    #telescope-nvim #not working but why 
    neo-tree-nvim
    nvim-web-devicons
    nvim-lspconfig
    {
      plugin = dracula-nvim;
      #config = builtins.readFile ./theme.lua;
    }
    nvim-treesitter.withAllGrammars
    bufferline-nvim
  ];
}
