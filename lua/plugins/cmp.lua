local plugin = { "hrsh7th/nvim-cmp" }

plugin.dependencies = {
	-- Sources for nvim-cmp to fetch completion items from
	{ "hrsh7th/cmp-buffer" },       -- Source for buffer words
	{ "hrsh7th/cmp-path" },         -- Source for file paths
	{ "saadparwaiz1/cmp_luasnip" }, -- Source for LuaSnip snippets

	-- Snippet plugins
	{
		"L3MON4D3/LuaSnip",          -- Snippet engine for managing code snippets
		version = "v2.*",            -- Use the latest major version
		build = "make install_jsregexp"  -- Optional: enables regex features for snippets
	},
	{ "rafamadriz/friendly-snippets" }, -- Collection of common snippets
}

function plugin.opts(_, opts)
	opts.sources = {
		{ name = "lazydev", group_index = 0 }, -- Special source for Lua/Nvim dev
		{ name = "path" },                      -- Path suggestions
		{ name = "nvim_lsp" },                  -- LSP suggestions
		{ name = "buffer",  keyword_length = 3 }, -- Buffer words, triggered after typing 3+ characters
		{ name = "luasnip", keyword_length = 2 }, -- Snippet suggestions, triggered after 2+ characters
	}
	opts.formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)          -- Customize display icons for each source
			local menu_icon = {
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}
			item.menu = menu_icon[entry.source.name] -- Assigns icon based on the source type
			return item
		end,
	}

	local luasnip = require("luasnip")
	local cmp = require("cmp")

	opts.snippet = {
		expand = function(args)                 -- Snippet expansion using LuaSnip
			luasnip.lsp_expand(args.body)
		end
	}

	opts.window = {
		completion = cmp.config.window.bordered(), -- Bordered window for completion
		documentation = cmp.config.window.bordered(), -- Bordered window for docs/help
	}

	local select_opts = { behavior = cmp.SelectBehavior.Select } -- Selection behavior for completion

	opts.mapping = {
		["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
		["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Scroll docs down

		["<C-e>"] = cmp.mapping.abort(),         -- Abort completion
		["<C-Space>"] = cmp.mapping.complete(),  -- VSCode-style manual trigger for suggestions

		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter key to confirm selection

		-- Snippet navigation in placeholders
		["<C-f>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)                    -- Jump to next snippet placeholder
			else
				fallback()                         -- Fallback if no placeholders available
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)                   -- Jump to previous snippet placeholder
			else
				fallback()                         -- Fallback if no placeholders available
			end
		end, { "i", "s" }),

		-- Tab and Shift-Tab for navigating and completing
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item(select_opts)  -- Select the next item in the menu
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()           -- Expand or jump to next snippet placeholder
			else
				fallback()                         -- Fallback if no other action possible
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)  -- Select the previous item in the menu
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)                   -- Jump to the previous snippet placeholder
			else
				fallback()                         -- Fallback if no other action possible
			end
		end, { "i", "s" }),
	}
end

function plugin.config(_, opts)
	vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Recommended completion options for a better UX

	-- Load snippets from VSCode-compatible sources
	require("luasnip.loaders.from_vscode").lazy_load()

	require("cmp").setup(opts) -- Apply the configured options to nvim-cmp
end

return plugin
