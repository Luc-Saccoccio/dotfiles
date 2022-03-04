set formatprg=rustfmt
let g:ale_rust_rls_toolchain = 'stable'

nnoremap gh :ALEGoToDefinition<CR>
let g:ale_linters = {
      \'rust': ['rustfmt'],
      \}
