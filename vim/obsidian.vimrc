" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back<CR>
exmap forward obcommand app:go-forward
nmap <C-i> :forward<CR>

" Emulate vim-surround with mini.surround mappings in normal mode
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_parens surround ( )
exmap surround_brackets surround [ ]
exmap surround_braces surround { }
exmap surround_backticks surround ` `

nunmap s

nmap sa] :surround_wiki<CR>
nmap sa" :surround_double_quotes<CR>
nmap sa' :surround_single_quotes<CR>
nmap sa( :surround_parens<CR>
nmap sa[ :surround_brackets<CR>
nmap sa{ :surround_braces<CR>
nmap sa` :surround_backticks<CR>
