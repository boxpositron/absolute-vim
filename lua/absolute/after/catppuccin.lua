local theme = require("catppuccino")

theme.setup({
    flavour = "mocha",
    transparent_background = true,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
})
