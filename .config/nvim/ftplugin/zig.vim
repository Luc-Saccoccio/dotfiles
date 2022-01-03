setlocal expandtab
setlocal tabstop=8
setlocal softtabstop=4
setlocal smartindent
setlocal shiftwidth=4
setlocal makeprg=zig\ build-exe\ \%:S\ \$*
setlocal formatprg=zig\ fmt\ --stdin\ --ast-check
