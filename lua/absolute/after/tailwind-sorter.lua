local tws = require("tailwind-sorter")

tws.setup({
	on_save_enabled = true,
	on_save_pattern = { "*.html", "*.js", "*.jsx", "*.tsx", "*.twig", "*.hbs", "*.php", "*.heex", "*.astro", "*.vue" }, -- T
})
