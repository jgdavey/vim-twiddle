" twiddle.vim - Argument order swapping
" Author:       Joshua Davey <josh@joshuadavey.com>
" Version:      0.1
"
" Licensed under the same terms as Vim itself.
" ============================================================================

if (exists("g:loaded_twiddle") && g:loaded_twiddle) || &cp
  " finish
endif
let g:loaded_twiddle = 1

let s:cpo_save = &cpo
set cpo&vim

function! TwiddleArguments() abort
  let cursor_pos = getpos(".")
  let [lin, comma_col] = searchpos(',', 'cnW', line('.'))
  if comma_col == 0
    return
  endif

  normal! eb
  let col = col(".")
  let word = escape(strpart(getline('.'), col - 1, comma_col - col), '(.)')
  echo word

  exec ':s/\v('.word.')(,\s*)([^,\)]+)/\3\2\1/'

  call setpos('.', cursor_pos)
  silent! call repeat#set("\<Plug>TwiddleArguments", -1)
endfunction

nnoremap <silent> <Plug>TwiddleArguments :<C-U>call TwiddleArguments()<CR>
nmap <leader>a <Plug>TwiddleArguments

let &cpo = s:cpo_save

" vim:set ft=vim ff=unix ts=4 sw=2 sts=2:
