"
" Filename: plugin/nofixme.vim
" Author: fisle
" License: MIT License
"

if exists('g:loaded_no_fixme') || v:version < 700
    finish
endif
let g:loaded_no_fixme = 1

let s:save_cpo = &cpo
set cpo&vim

augroup NoFixme
    autocmd!
    autocmd BufNewFile,BufReadPost * call nofixme#amount()
    autocmd BufEnter * call nofixme#amount()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
