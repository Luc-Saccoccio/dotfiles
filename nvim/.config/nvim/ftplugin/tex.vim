let g:tex_flavor="xelatex"
call deoplete#custom#var('omni', 'input_patterns', {
          \ 'tex': g:vimtex#re#deoplete
          \})
set spell spelllang=fr
autocmd VimLeave *.tex !texclear %
set foldmethod=indent

function ReplaceCoordinates(startx, starty, endx, endy) range
	:%s/startx/\=a:startx/g
	:%s/starty/\=a:starty/g
	:%s/endx/\=a:endx/g
	:%s/endy/\=a:endy/g
endfunction
command -range -nargs=+ Coordinates call ReplaceCoordinates(<f-args>)

" Mappings

inoremap ,lb \llbracket
inoremap ,rb \rrbracket
inoremap ,al \begin{align*}<Enter><Enter>\end{align*}<Enter><Enter><++><Esc>3ki
inoremap ,pmat \begin{pmatrix}<Enter><Enter>\end{pmatrix}<Enter><Enter><++><Esc>3ki
inoremap ,cas \begin{cases}<Enter>\end{cases}<Enter><++><Up><Up><End><Enter>
inoremap ,su $\left\{\begin{array}{l}<Enter><Enter><Enter>\end{array}<Enter>\right.$<Up><Up><Up>
inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
inoremap ,fi \begin{figure}<Enter>\centering<Enter><Enter>\end{figure}<Enter><Enter><++><Esc>3kA
inoremap ,img \begin{figure}[h]<Enter>\centering<Enter>\includegraphics[width=\textwidth]{}<Enter>\caption{}<Enter>\end{figure}<Enter><Enter>
inoremap ,em \emph{}<++><Esc>T{i
inoremap ,bf \textbf{}<++><Esc>T{i
vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
inoremap ,it \textit{}<++><Esc>T{i
inoremap ,ce \begin{center}<Enter><Enter>\end{center}<Esc>ji
inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
inoremap ,li <Enter>\item<Space>
inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
inoremap ,ver \begin{verse}<Enter><Enter>\end{verse}
inoremap ,sc \textsc{}<Space><++><Esc>T{i
inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
inoremap ,tt \texttt{}<Space><++><Esc>T{i
inoremap ,col \begin{multicols}{2}<Enter><Enter>\columnbreak<Enter><Enter>\end{multicols}
inoremap ,gh \left\\|\vec{}\right\\|<Esc>8hi
inoremap ,ov \overrightarrow{}<Esc>i
inoremap ,un \underline{}<Esc>i
inoremap ,tit \begin{center}<Enter>\Large{}<Enter>\end{center}<Enter>\vspace{3\baselineskip}<Esc>2k5l<Esc>i
inoremap ,nt \newpage<Enter>\begin{center}<Enter>\Large{}<Enter>\end{center}<Enter>\vspace{3\baselineskip}<Enter>\begin{linenumbers}[1]<Enter><Enter>\end{linenumbers}<Esc>5ki
inoremap ,emp \begin{empheq}[box=\fbox]{align}<Enter><Enter>\end{empheq}
inoremap ,sp \vspace{\baselineskip}
inoremap ,name \begin{multicols}{2}<Enter>\begin{flushleft}<Enter>Luc Saccoccio--Le Guennec<Enter><Enter>MPSI IV<Enter><Enter>\end{flushleft}<Enter>\columnbreak<Enter>\begin{flushright}<Enter>\today<Enter>\end{flushright}<Enter>\end{multicols}<Enter><Enter><Esc>
inoremap ,qu \begin{quote}<Enter>\attrib{ {\em }}<Enter>\end{quote}
inoremap ,func \begin{tikzpicture}<CR>\draw[thin, dashed, gray] (startx, starty) grid (endx, endy);<CR>\draw[->] (startx, 0) -- (endx, 0) node[right] {$x$};<CR>\draw[->] (0, starty) -- (0, endy) node[above] {$y$};<CR>\end{tikzpicture}<Esc>$v4<Up>0:Coordinates
inoremap ,tikz \begin{tikzpicture}<CR><CR>\end{tikzpicture}<Up>
inoremap ,cal \mathcal{}<Left>
inoremap ,V \vect{}<Left>
inoremap ,de \begin{description}<Enter><Enter>\end{description}<Enter><Enter><++><Esc>3kA\item<Space>
inoremap ,dq \begin{description}<Enter><Enter>\end{description}<Enter><Enter><++><Esc>3kA\item[$\circ$]<Space><Enter>\item[$\circ$]<Space><Enter>\item[$\circ$]<Space>

