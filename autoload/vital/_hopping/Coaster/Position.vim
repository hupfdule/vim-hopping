" ___vital___
" NOTE: lines between '" ___vital___' is generated by :Vitalize.
" Do not mofidify the code nor insert new lines before '" ___vital___'
if v:version > 703 || v:version == 703 && has('patch1170')
  function! vital#_hopping#Coaster#Position#import() abort
    return map({'new_from_list': '', 'new_from_dict': '', 'none': '', 'is_none': '', 'as': '', 'new_from_cursorpos': '', 'new_from_searchpos': '', 'is_position': '', 'as_pattern': '', 'new': ''},  'function("s:" . v:key)')
  endfunction
else
  function! s:_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
  endfunction
  execute join(['function! vital#_hopping#Coaster#Position#import() abort', printf("return map({'new_from_list': '', 'new_from_dict': '', 'none': '', 'is_none': '', 'as': '', 'new_from_cursorpos': '', 'new_from_searchpos': '', 'is_position': '', 'as_pattern': '', 'new': ''}, \"function('<SNR>%s_' . v:key)\")", s:_SID()), 'endfunction'], "\n")
  delfunction s:_SID
endif
" ___vital___
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


let s:x = 1
let s:y = 0
let s:lnum = 0
let s:lnum = 1

function! s:_is_dict(src)
	return type(a:src) == type({})
endfunction

function! s:_is_list(src)
	return type(a:src) == type([])
endfunction

function! s:_is_number(src)
	return type(a:src) == type(0)
endfunction


function! s:is_position(src)
	return s:_is_list(a:src) && len(a:src) == 2 && s:_is_number(a:src[0]) && s:_is_number(a:src[0])
endfunction


function! s:none()
	return []
endfunction


function! s:is_none(pos)
	return !s:is_position(a:pos) || s:none() == a:pos
endfunction


function! s:new(lnum, col)
	return [a:lnum, a:col]
endfunction


function! s:new_from_list(list)
	return len(a:list) == 2 && s:is_position(a:list)      ? a:list
\		 : len(a:list) == 4 && s:is_position(a:list[1:2]) ? a:list[1:2]
\		 : s:none()
endfunction


function! s:new_from_dict(dict)
	return s:_is_number(get(a:dict, "lnum", "")) && s:_is_number(get(a:dict, "col", "")) ? s:new(a:dict.lnum, a:dict.col)
\		 : s:none()
endfunction


function! s:new_from_cursorpos(cursor)
	return a:cursor
endfunction


function! s:new_from_searchpos(searchpos)
	return a:cursor[1:2]
endfunction


function! s:as(src)
	return s:_is_list(a:src) ? s:new_from_list(a:src)
\		 : s:_is_dict(a:src) ? s:new_from_dict(a:src)
\		 : s:none()
endfunction


function! s:as_pattern(pos)
	let pos = s:as(a:pos)
	return printf('\%%%dl\%%%dc', pos[0], pos[1])
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
