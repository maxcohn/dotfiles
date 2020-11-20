
" LaTeX highlighting - https://piware.de/2014/07/vim-config-for-markdownlatex-pandoc-editing/
" Inline formulas
syntax region Statement oneline matchgroup=Delimiter start="\$" end="\$"
" Environments
syntax region Statement matchgroup=Delimiter start="\\begin{.*}" end="\\end{.*}" contains=Statement
" Commands
syntax region Statement matchgroup=Delimiter start="{" end="}" contains=Statement
