{ config, pkgs, ... }:

{
	enable = true;
	defaultEditor = true;
	viAlias = true;
	vimAlias = true;

	extraConfig = ''
		set autoindent expandtab tabstop=2 shiftwidth=2
    filetype plugin indent on
    syntax enable
    set title
		'';

	extraLuaConfig = ''
		local cmp = require'cmp'

		cmp.setup({
				snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				end,
				},
				window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
						['<C-b>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.abort(),
						['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
						}),
				sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
						{ name = 'vsnip' }, -- For vsnip users.
						-- { name = 'luasnip' }, -- For luasnip users.
						-- { name = 'ultisnips' }, -- For ultisnips users.
						-- { name = 'snippy' }, -- For snippy users.
						}, {
						{ name = 'buffer' },
						})
		})

	-- Set configuration for specific filetype.
		cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
						{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
						}, {
						{ name = 'buffer' },
						})
				})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
				{ name = 'buffer' }
				}
				})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
						{ name = 'path' }
						}, {
						{ name = 'cmdline' }
						})
				})

	-- Set up lspconfig.
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
		require('lspconfig')['qml_lsp'].setup {
			capabilities = capabilities
		}
	require('lspconfig')['rnix'].setup {
		capabilities = capabilities
	}
	local dracula = require("dracula")
		dracula.setup({
				-- customize dracula color palette
				colors = {
				bg = "#282A36",
				fg = "#F8F8F2",
				selection = "#44475A",
				comment = "#6272A4",
				red = "#FF5555",
				orange = "#FFB86C",
				yellow = "#F1FA8C",
				green = "#50fa7b",
				purple = "#BD93F9",
				cyan = "#8BE9FD",
				pink = "#FF79C6",
				bright_red = "#FF6E6E",
				bright_green = "#69FF94",
				bright_yellow = "#FFFFA5",
				bright_blue = "#D6ACFF",
				bright_magenta = "#FF92DF",
				bright_cyan = "#A4FFFF",
				bright_white = "#FFFFFF",
				menu = "#21222C",
				visual = "#3E4452",
				gutter_fg = "#4B5263",
				nontext = "#3B4048",
				white = "#ABB2BF",
				black = "#191A21",
				},
				       -- show the '~' characters after the end of buffers
					       show_end_of_buffer = true, -- default false
					       -- use transparent background
					       transparent_bg = true, -- default false
					       -- set custom lualine background color
					       lualine_bg_color = "#44475a", -- default nil
					       -- set italic comment
					       italic_comment = true, -- default false
					       -- overrides the default highlights with table see `:h synIDattr`
					       overrides = {},
				       -- You can use overrides as table like this
					       -- overrides = {
						       --   NonText = { fg = "white" }, -- set NonText fg to white
							       --   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
							       --   Nothing = {} -- clear highlight of Nothing
							       -- },
				       -- Or you can also use it like a function to get color from theme
					       -- overrides = function (colors)
					       --   return {
						       --     NonText = { fg = colors.white }, -- set NonText fg to white of theme
							       --   }
				-- end,
		})
	vim.cmd[[colorscheme dracula]]
		'';

	plugins = with pkgs.vimPlugins; [
		telescope-nvim
			nvim-web-devicons

			nvim-lspconfig
			nvim-cmp
			cmp-nvim-lsp
			cmp-cmdline
			cmp-path
			cmp-buffer

			dracula-nvim


			nvim-treesitter.withAllGrammars
			bufferline-nvim
	];
}
