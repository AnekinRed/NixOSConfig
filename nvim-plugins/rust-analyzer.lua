return {
    {
        "anekin/rust-analyzer",
        init = function()
            vim.lsp.config['rust-analyzer'] = {
  cmd = { 'rust-analyzer' },
  -- Filetypes to automatically attach to.
  filetypes = { 'rs' },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { 'Cargo.toml' }
}
vim.lsp.enable('rust-analyzer')
        end,
    },
}


