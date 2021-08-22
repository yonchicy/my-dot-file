function!myspacevim#before()abort
    nnoremap H ^
    nnoremap L $
    imap <c-f> <c-o>a
    imap <c-e> <c-o>A
    set cursorcolumn
    :autocmd InsertEnter * set nocursorcolumn
    :autocmd InsertLeave * set cursorcolumn

endfunction
