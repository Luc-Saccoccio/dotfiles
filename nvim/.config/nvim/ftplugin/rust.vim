let g:rustfmt_command = 'rustfmt'
let g:ale_rust_rls_toolchain = 'stable'

nnoremap gh :ALEGoToDefinition<CR>
let g:ale_fixers = {
      \   'rust': ['rustfmt'],
      \}

let g:ale_linters = {
      \'rust': ['rustfmt'],
      \}
