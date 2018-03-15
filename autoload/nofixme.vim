"
" Filename: autoload/nofixme.vim
" Author: fisle
" License: MIT License
"

let s:save_cpo = &cpo
set cpo&vim

function! nofixme#amount() abort
    redir => b:output
    silent call nofixme#grep()
    redir END

    try
        let b:count = split(b:output)[0]
    catch E684
        " If splitting fails, return 0
        let b:count = 0
    endtry

    return b:count == 0 ? '' : b:count . "XXX"
endfunction

function! nofixme#grep() abort
    try
        exec '%s/\(FIXME\|TODO\|XXX\)//ng'
    catch E486
        " Catch pattern not found
        return ''
    endtry
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
