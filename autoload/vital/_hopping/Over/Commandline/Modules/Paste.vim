" ___vital___
" NOTE: lines between '" ___vital___' is generated by :Vitalize.
" Do not mofidify the code nor insert new lines before '" ___vital___'
if v:version > 703 || v:version == 703 && has('patch1170')
  function! vital#_hopping#Over#Commandline#Modules#Paste#import() abort
    return map({'make': ''},  'function("s:" . v:key)')
  endfunction
else
  function! s:_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
  endfunction
  execute join(['function! vital#_hopping#Over#Commandline#Modules#Paste#import() abort', printf("return map({'make': ''}, \"function('<SNR>%s_' . v:key)\")", s:_SID()), 'endfunction'], "\n")
  delfunction s:_SID
endif
" ___vital___
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


let s:module = {
\	"name" : "Paste"
\}

function! s:module.on_char_pre(cmdline)
	if a:cmdline.is_input("<Over>(paste)")
		let register = v:register == "" ? '"' : v:register
		call a:cmdline.insert(tr(getreg("*"), "\n", "\r"))
		call a:cmdline.setchar('')
	endif
endfunction


function! s:make()
	return deepcopy(s:module)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
