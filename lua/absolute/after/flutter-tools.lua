local flutter_tools = require('flutter-tools')

flutter_tools.setup({
    decorations = {
        statusline = {
            app_version = true,
            device = true,
            project_config = true,
        }
    },
    fvm = true,
})
