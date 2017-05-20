\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CuartillaSafa}[2013/04/20 Note taking class]

\def\printbuilddate{\footnotetext{\tiny Documento compilado el \today\ a las \currenttime}}
\def\enableindexbuilddate{\renewcommand{\compdate}{\tiny{\today\, \currenttime}}}
\def\titlepagebuilddate{\par \vspace{3pt} \tiny \today\, \currenttime \vspace{-4pt}}
\newif\if@apuntestitlepage
\newif\if@shortheader
\@shortheaderfalse


\newcommand{\organization}{Sagrada Familia}

\DeclareOption{nobuilddate}{%
	\def\printbuilddate{}%
	\def\enableindexbuilddate{}%
	\def\titlepagebuilddate{}%
}

\DeclareOption{titlepage}{
	\@apuntestitlepagetrue
	\PassOptionsToClass{\CurrentOption}{custombase}
}

\DeclareOption{notitlepage}{
	\@apuntestitlepagefalse
	\PassOptionsToClass{\CurrentOption}{custombase}
}

\DeclareOption{shortheader}{
	\@shortheadertrue
}




\DeclareOption{bibnumbers}{\PassOptionsToPackage{numbers}{natbib}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{custombase}}

\ExecuteOptions{titlepage}
\ProcessOptions

\LoadClass{custombase}

\RequirePackage{pdfpages}
\RequirePackage{datetime}
\RequirePackage{environ}
\RequirePackage{pgfkeys}
\RequirePackage{natbib}
\RequirePackage[nottoc]{tocbibind}% bibliografía y el índice no aparecen en el índice del pdf sin esta línea mágica. No sabemos qué hace, pero será mejor que tengas un buen motivo para quitarla

% Hacemos que el enlace al índice funcione bien.
\let\oldindex\printindex
\def\printindex{\clearpage\phantomsection\oldindex} % Simplemente hacemos que \printindex inserte un marcador de sección que se pueda enlazar

\if@removechapters
	\numberwithin{equation}{section}
\fi

%%%% Página de título superguay.


% Esto nos viene bien por si luego queremos
% reemplazar el título (en traducciones por ejemplo).

% Incluimos el abstract (resumen)

% Primero eliminamos la definición del entorno abstract, si es que está.
% (si usamos \renewenvironment peta en algún caso extraño).
\let\abstract\@undefined
\let\endabstract\@undefined
\newif\if@abstractset % Para ver si el usuario lo ha configurado o no.
\NewEnviron{abstract}{
	\global\@abstractsettrue		% Decimos que el abstract se ha usado.
	\global\let\@abstractbody\BODY	% Y nos lo guardamos.
}

\def\and{\!,\ }
\renewcommand{\author}[1]{\def\theauthor{#1}}

\newif\if@showsignature

% Preparamos las opciones
\pgfkeys{
	/apntstitle/.is family, /apntstitle,
	signature/.is choice,
	signature/true/.code = {\@showsignaturetrue},
	signature/false/.code = {\@showsignaturefalse},
	default/.style = {signature = true} % Argumentos por defecto
}

% Ejecutamos los argumentos por defecto por si el usuario no pone
% \titlesetup en el documento
\pgfkeys{/apntstitle, default}

% Hay que hacer esta chapuza de pasar los argumentos a \maketitle antes con
% \titlesetup porque por alguna razón no puedo redefinir \maketitle con argumentos
% opcionales.

\newcommand{\compdate}{}

% Cabecera super molona
\fancyhf{}
\PrerenderUnicode{ÁáÉéÍíÓóÚúÑñ} % Para que salgan las tildes y demás mierdas en el título.

\setlength{\parskip}{2mm}
\setlength{\headheight}{15pt}

\apptocmd{\printindex}{\enableindexbuilddate}{}{}
\apptocmd{\maketitle}{\printbuilddate}{}{}

\newcommand{\placeholder}[1]{\begin{framed}\textit{\textbf{A rellenar:} #1}\end{framed}}


\usepackage{array}
\usepackage{enumerate}


\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}



\newcommand{\cabecera}{
	\begin{tabular}{L{2cm}L{6cm}L{5cm}}
	Número: & Apellidos: & Nombre:
	\end{tabular}
	
	\noindent\normalfont\textcolor{gray}{\hrulefill}
}


\newcounter{ejer}[section]



\makeindex
