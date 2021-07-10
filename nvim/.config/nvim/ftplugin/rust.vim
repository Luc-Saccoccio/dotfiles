let g:racer_cmd = "/usr/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
let g:rustfmt_command = 'rustfmt'
let g:ale_rust_rls_toolchain = 'stable'

nnoremap gh :ALEGoToDefinition<CR>
let g:ale_fixers = {
      \   'rust': ['rustfmt'],
      \}

let g:ale_linters = {
      \'rust': ['rust-analyzer', 'rustfmt'],
      \}
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {'rust': ['ale', 'racer']})
