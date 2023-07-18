local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local util = require('vince.util')

local root_pattern = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "jsonls" },
})

-- lua
lspconfig.lua_ls.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

-- rust
lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    cmd = {
        "rustup", "run", "stable", "rust-analyzer"
    }
}

-- clangdeez
lspconfig.clangd.setup {
    capabilities = capabilities,
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp" },
    root_dir = function(fname)
        local filename = util.path.is_absolute(fname) and fname
            or util.path.join(vim.loop.cwd(), fname)
        return root_pattern(filename) or util.path.dirname(filename)
    end,
};

-- typescript
lspconfig.tsserver.setup {
    capabilities = capabilities,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = util.root_pattern("package.json"),
}

-- ocaml
lspconfig.ocamllsp.setup {
    capabilities = capabilities,
    cmd = { "ocamllsp" },
    filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
    root_pattern = util.root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace"),
}

-- gopls
lspconfig.gopls.setup {
    capabilities = capabilities,
    cmd = { "/home/vince/go/bin/gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    single_file_support = true,
}

-- python
lspconfig.pyright.setup {
    capabilities = capabilities,
}

-- cmake
lspconfig.cmake.setup {
    capabilities = capabilities,
    cmd = { "/home/vince/.local/bin/cmake-language-server" },
    filetypes = { "cmake" },
    init_options = {
        buildDirectory = "build",
    },
    root_dir = util.root_pattern('CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake'),
    single_file_support = true,
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
