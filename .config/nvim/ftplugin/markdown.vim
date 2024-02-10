set expandtab
set shiftwidth=2
set tabstop=2
set smartindent
set autoindent
set foldmethod=indent
set makeprg=compiler\ %
set formatprg=pandoc\ -t\ markdown-simple_tables

inoremap ,cd ⋅
inoremap ,& ∧
inoremap ,d <C-R>=strftime('%F')<C-M>

" Mappings
nnoremap <C-p> :VimtexTocToggle<CR>
inoremap ,V \vect{}<Left>
inoremap ,al \begin{align*}<Enter>\end{align*}<Enter><++><Esc>2ko
inoremap ,ans \begin{Answer}<Enter><Enter>\end{Answer}<Enter><Enter><++><Esc>3kA
inoremap ,bf \textbf{}<++><Esc>T{i
inoremap ,cal \mathcal{}<Left>
inoremap ,cas \begin{cases}<Enter>\end{cases}<Enter><++><Up><Up><End><Enter>
inoremap ,ce \begin{center}<Enter><Enter>\end{center}<Esc>ji
inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
inoremap ,col \begin{multicols}{2}<Enter><Enter>\columnbreak<Enter><Enter>\end{multicols}
inoremap ,cor \begin{corollary}<Enter><BS>\end{corollary}<Enter><Enter><++><Esc>3ko
inoremap ,dec \begin{description}<Enter><Enter>\end{description}<Enter><Enter><++><Esc>3kA\item<Space>
inoremap ,def \begin{definition}<Enter><BS>\end{definition}<Enter><Enter><++><Esc>3ko
inoremap ,eg \begin{example}<Enter><BS>\end{example}<Enter><Enter><++><Esc>3ko
inoremap ,dq \begin{description}<Enter><Enter>\end{description}<Enter><Enter><++><Esc>3kA\item[$\circ$]<Space><Enter>\item[$\circ$]<Space><Enter>\item[$\circ$]<Space>
inoremap ,em \emph{}<++><Esc>T{i
inoremap ,emp \begin{empheq}[box=\fbox]{align}<Enter><Enter>\end{empheq}
inoremap ,ex \begin{Exercise}<Enter><Enter>\end{Exercise}<Enter><Enter><++><Esc>3kA
inoremap ,fi \begin{figure}<Enter>\centering<Enter><Enter>\end{figure}<Enter><Enter><++><Esc>3kA
inoremap ,fr \begin{frame}{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
inoremap ,func \begin{tikzpicture}<CR>\draw[thin, dashed, gray] (startx, starty) grid (endx, endy);<CR>\draw[->] (startx, 0) -- (endx, 0) node[right] {$x$};<CR>\draw[->] (0, starty) -- (0, endy) node[above] {$y$};<CR>\end{tikzpicture}<Esc>$v4<Up>0:Coordinates
inoremap ,gh \left\\|\vec{}\right\\|<Esc>8hi
inoremap ,img \begin{figure}[h]<Enter>\centering<Enter>\includegraphics[width=\textwidth]{}<Enter>\caption{}<Enter>\end{figure}<Enter><Enter>
inoremap ,it \textit{}<++><Esc>T{i
inoremap ,lb \llbracket
inoremap ,lem \begin{lemma}<Enter>\end{lemma}<Enter><Enter><++><Esc>3ko
inoremap ,li <Enter>\item<Space>
inoremap ,ma \begin{matrix}<Enter>\end{matrix}<Enter><Enter><++><Esc>3ko
inoremap ,name \begin{multicols}{2}<Enter>\begin{flushleft}<Enter>Luc Saccoccio--Le Guennec<Enter><Enter>MPSI IV<Enter><Enter>\end{flushleft}<Enter>\columnbreak<Enter>\begin{flushright}<Enter>\today<Enter>\end{flushright}<Enter>\end{multicols}<Enter><Enter><Esc>
inoremap ,nt \newpage<Enter>\begin{center}<Enter>\Large{}<Enter>\end{center}<Enter>\vspace{3\baselineskip}<Enter>\begin{linenumbers}[1]<Enter><Enter>\end{linenumbers}<Esc>5ki
inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><++><Esc>2kA\item<Space>
inoremap ,ov \overrightarrow{}<Esc>i
inoremap ,pm \begin{pmatrix}<Enter>\end{pmatrix}<Enter><Enter><++><Esc>3ko
inoremap ,dem \begin{proof}<Enter>\end{proof}<Enter><Enter><++><Esc>3ko
inoremap ,pro \begin{proposition}<Enter><BS>\end{proposition}<Enter><Enter><++><Esc>3ko
inoremap ,qu \begin{quote}<Enter>\attrib{ {\em }}<Enter>\end{quote}
inoremap ,rb \rrbracket
inoremap ,re \begin{remark}<Enter><BS>\end{remark}<Enter><Enter><++><Esc>3ko
inoremap ,sc \textsc{}<Space><++><Esc>T{i
inoremap ,se \section{}<Enter><Enter><++><Esc>2kf}i
inoremap ,sse \subsection{}<Enter><Enter><++><Esc>2kf}i
inoremap ,ssse \subsubsection{}<Enter><Enter><++><Esc>2kf}i
inoremap ,sp \vspace{\baselineskip}
inoremap ,ssi si et seulement si
inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
inoremap ,the \begin{theorem}<Enter>\end{theorem}<Enter><Enter><++><Esc>3ko
inoremap ,tikz \begin{tikzpicture}<CR><CR>\end{tikzpicture}<Up>
inoremap ,tit \begin{center}<Enter>\Large{}<Enter>\end{center}<Enter>\vspace{3\baselineskip}<Esc>2k5l<Esc>i
inoremap ,tt \texttt{}<Space><++><Esc>T{i
inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><++><Esc>2kA\item<Space>
inoremap ,un \underline{}<Esc>i
inoremap ,ver \begin{verse}<Enter><Enter>\end{verse}
inoremap ,< <++>
vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
