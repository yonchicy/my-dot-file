" A Vim plugin that defines a parameter text object.
" Maintainer: David Larson <david@thesilverstream.com>
" Last Change: Mar 11, 2020
" Version: 1.1
"
" This script defines a parameter text object. A parameter is the text between
" parentheses or commas, typically found in a function's argument list.
"
" See:
" :help text-objects
"   for a description of what can be done with text objects.
" Also See:
" :help a(
"   If you want to operate on the parentheses also.
"
" Like all the other text-objects, a parameter text object can be selected
" following these commands: 'd', 'c', 'y', 'v', etc. The script defines these
" operator mappings:
"
"    aP    "a parameter", select a parameter, including one comma (if there is
"          one).
"
"    iP    "inner parameter", select a parameter, not including commas.
" 
" When constructing a "%" formatted string, use the "add" command to move the
" cursor to the corresponding argument. For example:
"
" printf("Your age is %d, your weight is %d and your height is %d inches.", age, weight, height)
" ----------------------------------------^ current cursor position
"
" Then from normal mode, type ",a", the cursor will move to the second format argument:
"
" printf("Your age is %d, your weight is %d and your height is %d inches.", age, weight, height)
" -------------------------------------------------------------------------------^ new cursor position
"
" You can go back to the corresponding "%" position by pressing ",A":
"
" printf("Your age is %d, your weight is %d and your height is %d inches.", age, weight, height)
" ----------------------------------------^ new cursor position
"
" If you would like to remap the commands then you can prevent the default
" mappings if you set g:no_parameter_object_maps = 1 in your .vimrc file. Then
" remap the commands as desired, like this:
"
"    let g:no_parameter_object_maps = 1
"    vmap <silent> ia <Plug>ParameterObjectI
"    omap <silent> ia <Plug>ParameterObjectI
"    vmap <silent> aa <Plug>ParameterObjectA
"    omap <silent> aa <Plug>ParameterObjectA
"    nmap <silent> ,p <Plug>ParameterObjectAdd
"    nmap <silent> ,b <Plug>ParameterObjectBack

if exists("loaded_parameter_objects") || &cp || v:version < 701
	finish
endif
let loaded_parameter_objects = 1

if !exists("g:no_parameter_object_maps") || !g:no_parameter_object_maps
	vmap <silent> iP <Plug>ParameterObjectI
	omap <silent> iP <Plug>ParameterObjectI
	vmap <silent> aP <Plug>ParameterObjectA
	omap <silent> aP <Plug>ParameterObjectA
	nmap <silent> ,a <Plug>ParameterObjectAdd
	nmap <silent> ,A <Plug>ParameterObjectBack
endif
vnoremap <silent> <script> <Plug>ParameterObjectI :<C-U>call <SID>parameter_object("i")<cr>
onoremap <silent> <script> <Plug>ParameterObjectI :call <SID>parameter_object("i")<cr>
vnoremap <silent> <script> <Plug>ParameterObjectA :<C-U>call <SID>parameter_object("a")<cr>
onoremap <silent> <script> <Plug>ParameterObjectA :call <SID>parameter_object("a")<cr>

nnoremap <silent> <script> <Plug>ParameterObjectAdd :call <SID>add()<cr>
nnoremap <silent> <script> <Plug>ParameterObjectBack :call <SID>back()<cr>

function! s:parameter_object(mode)
	let c = v:count1
	let ve_save = &ve
	set virtualedit=onemore
	let linenum = line('.')
	let colnum = col('.')
	let aborted = 0
	try
		" Search for the start of the parameter text object
		" Have to use searchpair (vs. search) because there could be function
		" calls within the argument list.
		if searchpair('(',',',')', 'bW', "s:skip()") <= 0
			let aborted = 1
			return
		endif

		" Get the character under the cursor.
		let l = getline('.')[col('.')-1]

		if a:mode == "a" && l == ','
			" Mark the comma if we found one and we're in "a" mode
			let got_one_comma = 1
			normal! ml
		else
			" Else mark the spot to the right of what was found
			normal! lmlh
		endif

		while c
			" Search for the end of the parameter text object
			if searchpair('(',',',')', 'W', "s:skip()") <= 0
				" Error. Couldn't find the other side
				let aborted = 1
				return
			endif
			let l = getline('.')[col('.')-1]
			if l == ')' && c > 1
				" found the last parameter when more is asked for, so abort
				let aborted = 1
				return
			endif
			let c -= 1
		endwhile

		if a:mode == "a" && l == ',' && !exists("got_one_comma")
			" Get rid of white space before the next argument
			normal! wh
		else
			normal! h
		endif
		" Important to not let the jump list update here so that CTRL-O can take
		" you back to the previous position (esp. if it's a %d)
		keepjumps normal! v`l
	finally
		if aborted
			call cursor(linenum, colnum)
		endif
		let &ve = ve_save
	endtry
endfunction
function! s:add()
	let flag = "s"
	" We're in a string, so we want to find the parameter
	" Find out where we are
	let part = strcharpart(getline('.'), 0, col('.')) " Cut out everything after the cursor

	" Cut out everything before the last double-quote
	let part = matchstr(part, '.*"\zs.*')

	" Remove all "%%"'s
	let part = substitute(part, '%%', '--', "g")

	" Count the number of %'s
	let num = count(part, "%")

	" Now go find that parameter location
	let l = ")"
	" Set the previous mark so we can go back with CTRL-O
	while num
		" Search for the end of the parameter text object
		if searchpair('(',',',')', 'W'.flag, "s:skip()") <= 0
			" Error. Couldn't find the other side
			normal! `'
			return
		endif
		let flag = ""
		let l = getline('.')[col('.')-1]
		if l == ')' && num > 1
			" found the last parameter when more is asked for, so just stay put
			break
		endif
		let num -= 1
	endwhile
	if l != ')'
		normal! w
	endif
endfunction
function! s:back()
	let flag = "s"
	" We are in a parameter list and we need to go back the right spot in the
	" string
	let num = -1
	let l = ""
	while l != '('
		if searchpair('(',',',')', 'Wb'.flag, "s:skip()") <= 0
			" Error. Couldn't find the other side
			" normal! `'
			return
		endif
		let flag = ""
		let l = getline('.')[col('.')-1]
		let num += 1
	endwhile
	" We're at "(", so go to the first '"'
	normal! f"
	while num
		call search('["%]', "Wz")
		let l = getline('.')[col('.')-1]
		if (l == '"')
			" Found the end of the string, so just stop
			break
		endif
		let num -= 1
	endwhile
endfunction
function! s:skip()
	let name = synIDattr(synID(line("."), col("."), 0), "name")
	if name =~? "comment"
		return 1
	elseif name =~? "string"
		return 1
	endif
	return 0
endfunction

" vim:fdm=marker fmr=function!\ ,endfunction
