{ config, pkgs, lib, ... }:
let
  lua = builtins.concatStringsSep "\n" (builtins.map builtins.readFile (lib.filesystem.listFilesRecursive ./lua));
in
{
  neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    coc.enable = true;
    coc.settings = {
      "languageserver" = {
        "nix" = {
          "command" = "rnix-lsp";
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
        augroup set-commentstring-ag
        autocmd!
        autocmd BufEnter *.nix,*.h :lua vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
        " when you've changed the name of a file opened in a buffer, the file type may have changed
        autocmd BufFilePost *.nix,*.h :lua vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
        augroup END
      '';

    extraLuaConfig =
      ''
        ${lua}
      '';

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      neo-tree-nvim
      nvim-web-devicons
      nvim-lspconfig
      dracula-nvim
      nvim-treesitter.withAllGrammars
      bufferline-nvim
      indent-blankline-nvim
      lualine-nvim
      nvim-comment
      vim-sleuth
      #coc-clangd # https://www.reddit.com/r/NixOS/comments/p01y4h/c_with_neovim_on_nixos/
    ];
  };
}
