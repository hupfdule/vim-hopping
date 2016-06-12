" ___vital___
" NOTE: lines between '" ___vital___' is generated by :Vitalize.
" Do not mofidify the code nor insert new lines before '" ___vital___'
if v:version > 703 || v:version == 703 && has('patch1170')
  function! vital#_hopping#Unlocker#Holder#File#import() abort
    return map({'is_makeable': '', 'make': ''},  'function("s:" . v:key)')
  endfunction
else
  function! s:_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
  endfunction
  execute join(['function! vital#_hopping#Unlocker#Holder#File#import() abort', printf("return map({'is_makeable': '', 'make': ''}, \"function('<SNR>%s_' . v:key)\")", s:_SID()), 'endfunction'], "\n")
  delfunction s:_SID
endif
" ___vital___
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:obj = {}

function! s:obj.get()
	return readfile(self.__file)
endfunction


function! s:obj.set(value)
	call writefile(a:value, self.__file)
	return self
endfunction


function! s:is_makeable(expr)
	return filereadable(a:expr)
endfunction


function! s:make(expr)
	let result = deepcopy(s:obj)
	let result.__file = a:expr
	return result
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
