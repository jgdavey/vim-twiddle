" twiddle.vim - Argument order swapping
" Author:       Joshua Davey <josh@joshuadavey.com>
" Version:      0.1
"
" Licensed under the same terms as Vim itself.
" ============================================================================

if (exists("g:loaded_twiddle") && g:loaded_twiddle) || &cp
  finish
endif
let g:loaded_twiddle = 1

let s:cpo_save = &cpo
set cpo&vim

function! TwiddleArguments()
  if !search(',', 'cnW')
    return
  endif

  let reg1 = getreg('q')
  let reg1type = getregtype('q')
  let reg2 = getreg('a')
  let reg2type = getregtype('a')
  let save_cursor = getpos(".")

  normal "qdiw"adwep"qp

  call setpos('.', save_cursor)
  call setreg('q', reg1, reg1type)
  call setreg('a', reg2, reg2type)
  silent! call repeat#set("\<Plug>TwiddleArguments", -1)
endfunction

nnoremap <silent> <Plug>TwiddleArguments :<C-U>call TwiddleArguments()<CR>
nmap <unique> <leader>a <Plug>TwiddleArguments

let &cpo = s:cpo_save

" vim:set ft=vim ff=unix ts=4 sw=2 sts=2:
