" ___vital___
" NOTE: lines between '" ___vital___' is generated by :Vitalize.
" Do not mofidify the code nor insert new lines before '" ___vital___'
if v:version > 703 || v:version == 703 && has('patch1170')
  function! vital#_hopping#Over#Commandline#Modules#KeyMapping#import() abort
    return map({'_vital_depends': '', 'make_emacs': '', 'make_vim_cmdline_mapping': '', '_vital_loaded': ''},  'function("s:" . v:key)')
  endfunction
else
  function! s:_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
  endfunction
  execute join(['function! vital#_hopping#Over#Commandline#Modules#KeyMapping#import() abort', printf("return map({'_vital_depends': '', 'make_emacs': '', 'make_vim_cmdline_mapping': '', '_vital_loaded': ''}, \"function('<SNR>%s_' . v:key)\")", s:_SID()), 'endfunction'], "\n")
  delfunction s:_SID
endif
" ___vital___
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! s:_vital_loaded(V)
	let s:Keymapping = a:V.import("Palette.Keymapping")
endfunction


function! s:_vital_depends()
	return [
\		"Palette.Keymapping",
\	]
endfunction


let s:emacs = {
\	"name" : "KeyMapping_emacs_like"
\}

function! s:emacs.keymapping(cmdline)
	return {
\		"\<C-f>" : {
\			"key" : "\<Right>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-b>" : {
\			"key" : "\<Left>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-n>" : {
\			"key" : "\<Down>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-p>" : {
\			"key" : "\<Up>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-a>" : {
\			"key" : "\<Home>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-e>" : {
\			"key" : "\<End>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-d>" : {
\			"key" : "\<Del>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<A-d>" : {
\			"key" : "\<C-w>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<A-b>" : {
\			"key" : "\<S-Left>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<A-f>" : {
\			"key" : "\<S-Right>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\	}
endfunction


function! s:make_emacs()
	return deepcopy(s:emacs)
endfunction


let s:vim_cmdline_mapping = {
\	"name" : "KeyMapping_vim_cmdline_mapping",
\	"_cmaps" : {}
\}

function! s:_convert_sid(rhs, sid) abort
	return substitute(a:rhs, '<SID>', '<SNR>' . a:sid . '_', 'g')
endfunction

function! s:_auto_cmap()
	let cmaps = {}
	let cmap_info = s:Keymapping.rhs_key_list("c", 0, 1)
	" vital-over currently doesn't support <buffer> mappings
	for c in filter(cmap_info, "v:val['buffer'] ==# 0")
		let cmaps[s:Keymapping.escape_special_key(c['lhs'])] = {
		\   'noremap' : c['noremap'],
		\   'key'  : s:Keymapping.escape_special_key(s:_convert_sid(c['rhs'], c['sid'])),
		\   'expr' : s:Keymapping.escape_special_key(c['expr']),
		\ }
	endfor
	return cmaps
endfunction


function! s:vim_cmdline_mapping.on_enter(cmdline)
	let self._cmaps = s:_auto_cmap()
endfunction


function! s:vim_cmdline_mapping.keymapping(cmdline)
	return self._cmaps
endfunction


function! s:make_vim_cmdline_mapping()
	return deepcopy(s:vim_cmdline_mapping)
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
