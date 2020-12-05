-- Python
require'lspconfig'.pyls.setup({
    enable = true,
    on_attach = require'completion'.on_attach,
    settings = {
        pyls = {
            plugins = {
                pycodestyle = {
                    enable = true,
                    ignore = "W191"
                }
            }
        }
    }
})
-- Typescript, Javascript
require'lspconfig'.tsserver.setup({enable = true, on_attach = require'completion'.on_attach})
-- Lua
require'lspconfig'.sumneko_lua.setup({
    on_attach = require('completion').on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim"
                }
            }
        }
    }
})
-- JSON
require'lspconfig'.jsonls.setup{({on_attach = require'completion'.on_attach})}
-- YAML
require'lspconfig'.yamlls.setup{({on_attach = require'completion'.on_attach})}
-- HTML
require'lspconfig'.html.setup{({on_attach = require'completion'.on_attach})}
-- CSS
require'lspconfig'.cssls.setup{({on_attach = require'completion'.on_attach})}
-- Docker
require'lspconfig'.dockerls.setup{({on_attach = require'completion'.on_attach})}
