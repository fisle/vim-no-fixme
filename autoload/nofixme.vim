"
" Filename: autoload/nofixme.vim
" Author: fisle
" License: MIT License
"

let s:save_cpo = &cpo
set cpo&vim

function! nofixme#amount() abort
    if !&modifiable
        return ''
    endif
    let line = ''
    
    try
        redir => b:output
        silent call nofixme#grep("TODO")
        redir END
        let b:count = split(b:output)[0]
        let line = line . b:count . " TODO "
    catch E684
        let b:count = 0
    endtry
    
    try
        redir => b:output
        silent call nofixme#grep("FIXME")
        redir END
        let b:count = split(b:output)[0]
        let line = line . b:count . " FIXME "
    catch E684
        let b:count = 0
    endtry
    
    try
        redir => b:output
        silent call nofixme#grep("XXX")
        redir END
        let b:count = split(b:output)[0]
        let line = line . b:count . " XXX "
    catch E684
        let b:count = 0
    endtry
    return line
endfunction

function! nofixme#grep(tag) abort
    try
        exec "%s/" . a:tag . "//ng"
    catch E486
        " Catch pattern not found
        return ''
    endtry
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
