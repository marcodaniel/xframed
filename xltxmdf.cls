%% documentclass only for the documentation of mdframed
%% This documentclass isn't maintanened or efficient for writing
%%
%%
%% Copyright (c) 2012 Marco Daniel
%%
%% This package may be distributed under the terms of the LaTeX Project
%% Public License, as described in lppl.txt in the base LaTeX distribution.
%% Either version 1.0 or, at your option, any later version.


%%$Id: xltxmdf.cls 13 2012-06-08 14:11:22Z marco $
%%$Rev: 13 $
%%$Author: marco $
%%$Date: 2012-06-08 16:11:22 +0200 (Fr, 08 Jun 2012) $

\RequirePackage{expl3}
\GetIdInfo$Id: xltxmdf.cls 13 2012-06-08 14:11:22Z marco $
          {documentation class for Marco Daniel}

\ProvidesExplClass{\ExplFileName}
     {\ExplFileDate}{\ExplFileVersion}{\ExplFileDescription}

\RequirePackage{l3keys2e,xparse}
\keys_define:nn { ltxmdf }
  {
    tocdepth  .int_set:N  = \l_ltxmdf_tocdepth_int   ,
    lipsum    .bool_set:N = \l_ltxmdf_lipsum_bool    ,
    showframe .bool_set:N = \l_ltxmdf_showframe_bool ,
  }
\keys_set:nn { ltxmdf }
 {
  tocdepth = 2
 }

\ProcessKeysOptions { ltxmdf }

\LoadClassWithOptions { scrartcl }

\RequirePackage{ifxetex,ifluatex}
\RequirePackage{selinput}
\SelectInputMappings{
  adieresis  = {ä} ,
  germandbls = {ß} ,
  Euro       = {€} ,
}

\RequirePackage{etoolbox}
\RequirePackage[left=2.5cm,right=2.5cm,top=3cm,bottom=3cm]{geometry}

\pdftex_if_engine:TF
 {
  \RequirePackage[T1]{fontenc}
  \RequirePackage[scaled=0.82]{beramono}
  \RequirePackage{microtype}
 }
 {
  \RequirePackage{fontspec}
  \setmonofont[Mapping=tex-text]{Courier New}
 }

\RequirePackage[french=quotes]{csquotes}
\RequirePackage{xspace}
\begingroup
  \text@command\relax
  \global\let\xspace@check@icr\check@icr
\endgroup
\xspaceaddexceptions{\xspace@check@icr}
\RequirePackage{multicol}\columnseprule0.4pt
\RequirePackage{scrpage2}
\RequirePackage{listings}
\RequirePackage[inline]{enumitem}
\RequirePackage{amsmath}
\RequirePackage[amsmath]{ntheorem}
\RequirePackage{array,booktabs}
\RequirePackage{xcolor,tikz}
\RequirePackage{graphicx}
\RequirePackage[numbered]{hypdoc}
%set columns of index
\c@IndexColumns = 2

\hypersetup{%
        breaklinks=true,
        pdftitle={Documenation of mdframed},%
        pdfauthor={Marco Daniel},%
        colorlinks=true,%
        linkcolor=ltxmdfblue,
        urlcolor=cyan,
        bookmarksdepth= \int_use:N \l_ltxmdf_tocdepth_int,
}
\bool_if:NT \l_ltxmdf_showframe_bool
 {
  \RequirePackage{showframe}
 }
\bool_if:NT \l_ltxmdf_lipsum_bool
 {
  \RequirePackage{lipsum}
  \RequirePackage{kantlipsum}
 }

%Kopf- und Fusszeilen
\clearscrheadfoot
\pagestyle{scrheadings}
\automark[subsection]{section}
\renewcommand{\sectionmark}[1]{\markboth{\sectionmarkformat #1}{}}%
\renewcommand{\subsectionmark}[1]{\markright{\subsectionmarkformat #1}}
\ihead{\rightmark}
\ohead{\leftmark}
\ofoot{\pagemark}
\ifoot{{\ExplFileDate}\qquad SVN~version:~{\ExplFileVersion}\qquad{\ExplFileName}}



%Tikz und Farbe
%tikzlibrary needs special handling
\ExplSyntaxOff
\usetikzlibrary{calc,backgrounds,arrows,matrix}
\ExplSyntaxOn
\colorlet{ltxmdfblue}{blue!30!black}

\lstset{keywordstyle=\bfseries}
\lstdefinestyle{lstltxmdf}{%
     basicstyle=\small\ttfamily,
     language={[LaTeX]TeX},
     basicstyle=\small,%
     xleftmargin=20pt,%
     xrightmargin=20pt,%
     frame=single,%
     rulecolor=\color{ltxmdfblue},%
     framesep=5pt,%
     framerule=1pt,%
     texcsstyle=*\color{red!50!black}\bfseries,
     moretexcs=intertext,
     keywordstyle=\color{blue!60!black}\bfseries,%
     columns=fullflexible,%
     fontadjust=true,%
     basewidth=0.65em,%
     breakatwhitespace=true,
     morekeywords=[2]{@length},
     keywordstyle=[2]\color{red!50!black}\bfseries,
     morekeywords={outerlinewidth,leftmargin,rightmargin,backgroundcolor,
                   outerlinecolor,innertopmargin,splittopskip,skipbelow,
                   skipabove,ntheorem,theorem,lemma,mdframed,linecolor,
                   frametitle,infobox,innerlinewidth,roundcorner,leftline,
                   topline,splitbottomskip,middlelinewidth,middlelinecolor,
                   tikzsetting,rightline,bottomline,innerrightmargin,style,
                   linewidth,lem,section,definedstyle,mdfapptodefinestyle,
                   needspace,mdf@globalstyle@cnt,framemethod,ExampleText,
                   titregris,draw,gray,thick,fill,white,shading,exersicetitle,
                   exersicebackground,color,green,black,exercise,exercisepoints,
                   text,rectangle,rounded,corners,right,minimum,height,xshift,
                   at,exercisestyle,settings,frametitlefont,innerbottommargin,
                   innerleftmargin,frametitlerule,frametitlebelowskip,
                   frametitleaboveskip,frametitlebackgroundcolor,
                   frametitlerulecolor,picins,figure,hidealllines,fontcolor,
                   firstextra,secondextra,middleextra,singleextra,overlay,node},
     moretexcs={newmdtheoremenv,newmdenv,theoremstyle,mdfsetup,@length,
                   md@putbox@single,@tempboxa,mdf@,mdf@linewidth,
                   mdf@leftmargin@length,interruptlength,setlength,newrobustcmd,
                   overlaplines,appto,md@frame@leftline@singe,color,
                   md@frame@leftline@single,mdf@innerbottommargin@length,
                   mdf@middlelinewidth@length,mdfboundingboxheight,
                   md@frame@rightline@single,mdfboundingboxwidth,
                   mdf@innerrightmargin@length,mdfdefinestyle,
                   mdfapptodefinestyle,defcounter,tikzstyle,
                   pgfdeclarehorizontalshading,theexercise,mdf@@exercisepoints,
                   define@key,renewrobustcmd,mdfcreateextratikz,node,ifdefempty,
                   mdf@frametitlefont,dimexpr,mdframedtitleenv,ifstrempty,
                   @undefined,mdtheorem,surroundwithmdframed,@captype,@dblarg,
                   @newcaption,newcaption,mdflength,tikzset,path,p1,p2%
                   },%
}


\lstnewenvironment{tltxmdfexample}[1][]
  {\lstset{style=lstltxmdf,#1}}%
  {}


%%Maketitle angepasst:
\prop_new:N \l_ltxmdf_maketitleinformation_prop
\cs_set:Npn \title #1
 {
  \prop_put:Nnn \l_ltxmdf_maketitleinformation_prop { title } { #1 }
 }
\cs_set:Npn \subtitle #1
 {
  \prop_put:Nnn \l_ltxmdf_maketitleinformation_prop { subtitle } { #1 }
 }
\cs_set:Npn \author #1
 {
  \prop_put:Nnn \l_ltxmdf_maketitleinformation_prop { author } { #1 }
 }
\cs_set:Npn \version #1
 {
  \prop_put:Nnn \l_ltxmdf_maketitleinformation_prop { version } { #1 }
 }
\cs_set:Npn \date #1
 {
  \prop_put:Nnn \l_ltxmdf_maketitleinformation_prop { date } { #1 }
 }
\cs_set:Npn \introduction #1
 {
  \prop_put:Nnn \l_ltxmdf_maketitleinformation_prop { introduction } { #1 }
 }

\def\maketitle{%
 \clearpage
 \thispagestyle{empty}
 \group_begin:
   \group_begin:
    \pdfbookmark[1]{Title}{titlebook}
    \parindent\c_zero_dim
    \centering
     \color{ltxmdfblue}\Large\bfseries\sffamily
        \prop_get:Nn \l_ltxmdf_maketitleinformation_prop { title }
     \par
     \skip_vertical:n {.5\baselineskip}
     \normalfont\large\normalcolor
        \prop_get:Nn \l_ltxmdf_maketitleinformation_prop { subtitle }
     \par\kern.5\baselineskip\null\quad
        \prop_get:Nn \l_ltxmdf_maketitleinformation_prop { author }
     \hfill
        \prop_get:Nn \l_ltxmdf_maketitleinformation_prop { version }
     \hfill
        \prop_get:Nn \l_ltxmdf_maketitleinformation_prop { date }
     \hfill\quad\null
   \group_end:
     \par
     \skip_vertical:n {.5\baselineskip}
  \begin{abstract}
    \prop_get:Nn \l_ltxmdf_maketitleinformation_prop { introduction }
  \end{abstract}
     \par
     \skip_vertical:n {.2\baselineskip}
  \pdfbookmark[1]{\contentsname}{tocbook}
  \tableofcontents
 \group_end:
}

%table of contens anpassen:
\renewcommand\tableofcontents{%
  \int_set_eq:NN \c@tocdepth \l_ltxmdf_tocdepth_int
%\int_use:N \l_ltxmdf_tocdepth_int
%\setcounter{tocdepth}{\l_ltxmdf_tocdepth_int}%
  \begin{multicols}{2}[\centering\textbf{\sffamily\Large\contentsname}]
        \@starttoc{toc}
  \end{multicols}
}


%Modifkation of code
\tl_gput_left:Nn \theCodelineNo { \color{gray} }
\dim_set:Nn \MacroTopsep { 10pt }
%\tl_gput_right:Nn \MacroFont { \color{ltxmdfblue} }
\cs_set:Npn \MacroFont 
 {
  \color{ltxmdfblue}\small\ttfamily
 }

%Anweisung zur Darstellung

\NewDocumentCommand \Opt { m }
 {
  \hbox:n {\MacroFont #1}\xspace
 }

\NewDocumentCommand \Env { m }
 {
  \hbox:n {\MacroFont #1}\xspace
 }

\NewDocumentCommand \Cmd { m }
 {
  \hbox:n {\MacroFont \tl_to_str:n { #1 } }\xspace
 }

\NewDocumentCommand \Pack { m }
 {
  \hbox:n { \texttt { #1 } }\xspace
 }

\NewDocumentCommand \NOTE {}
 {
  \minisec{Note}
 }

\NewDocumentCommand \limitation { O{TikZ} }
 {
  \newline{\small~This~works~only~with~\Opt{framemethod=#1}.}
 }


\NewDocumentCommand \ExplOpt { o m }
 {
    \par
    \skip_vertical:n { .2\baselineskip }
    \noindent
    \hbox_to_wd:nn { \c_zero_dim }
                   {
                     \skip_horizontal:n { -2em }
                     \@bsphack
                      \MacroFont #2
                      \SpecialOptIndex{#2}
                     \@esphack
                    }
    \hfill\null
    \IfNoValueT { #1 }
      {
       \hbox:n { \small default=\ttfamily #1 }
      }
    \par
    \skip_vertical:n { .5ex }
    \noindent\ignorespaces
 }

\NewDocumentCommand \ExplEnv { o m }
 {
    \par
    \skip_vertical:n { .2\baselineskip }
    \noindent
    \hbox_to_wd:nn { \c_zero_dim }
                   {
                     \skip_horizontal:n { -2em }
                     \@bsphack
                      \MacroFont #2
                      \SpecialEnvIndex{#2}
                     \@esphack
                    }
    \hfill\null
    \IfNoValueT { #1 }
      {
       \hbox:n { \small default=\ttfamily #1 }
      }
    \par
    \skip_vertical:n { .5ex }
    \noindent\ignorespaces
 }

\NewDocumentCommand \ExplCmd { o m }
 {
    \par
    \skip_vertical:n { .2\baselineskip }
    \noindent
    \hbox_to_wd:nn { \c_zero_dim }
                   {
                     \skip_horizontal:n { -2em }
                     \@bsphack
                      \MacroFont \tl_to_str:n{ #2 }
                      \SpecialUsageIndex{#2}
                     \@esphack
                    }
    \hfill\null
    \IfNoValueT { #1 }
      {
       \hbox:n { \small default=\ttfamily #1 }
      }
    \par
    \skip_vertical:n { .5ex }
    \noindent\ignorespaces
 }


\IndexPrologue{
  \section*{Index}%
  \markboth{Index}{Index}
  The~index~only~collect~package~relevant~words.
}


\ExplSyntaxOff
\lstMakeShortInline[basicstyle=\small\ttfamily\color{blue!60!black}]{|}
\def\MakePrivateletters{%
 \@makeother\_\@makeother\@\@makeother\:}
\ExplSyntaxOn

\cs_generate_variant:Nn \tl_to_str:n {f}
\DeclareDocumentEnvironment { macro } { O{} m }
{
 \clist_set:Nn      \l_tmpa_clist  { #2 }
 \clist_if_empty:NF \l_tmpa_clist
  {
   \topsep\MacroTopsep \trivlist
   \def\makelabel##1{\makebox[0pt][l]{\kern-2em ##1}}%
   \int_set:Nn \l_tmpa_int { \clist_count:N \l_tmpa_clist }
   \item[\begin{tabular}{l}\toprule
                \clist_map_inline:Nn \l_tmpa_clist 
                  { 
                   \int_compare:nNnTF { \l_tmpa_int } = { \c_one }
                     { \MacroFont \tl_to_str:f { \token_to_str:N ##1 }\\
                                                  \bottomrule            }
                     { \MacroFont \tl_to_str:f { \token_to_str:N ##1 }\\ }
                    \int_gdecr:N \l_tmpa_int
                   }
               \end{tabular}]
   \leavevmode\par\kern\MacroTopsep\noindent\ignorespaces
   \global\advance\c@CodelineNo\@ne
   \global\advance\c@CodelineNo\m@ne
   \ignorespaces
  }
 }
 {
  \clist_if_empty:NF \l_tmpa_clist { \endtrivlist }
 }

\DeclareDocumentEnvironment { macromessage } { O{} m }
{
 \clist_set:Nn      \l_tmpa_clist  { #2 }
 \clist_if_empty:NF \l_tmpa_clist
  {
   \topsep\MacroTopsep \trivlist
   \def\makelabel##1{\makebox[0pt][l]{\kern-2em ##1}}%
   \int_set:Nn \l_tmpa_int { \clist_count:N \l_tmpa_clist }
   \item[\begin{tabular}{l}\toprule
                \clist_map_inline:Nn \l_tmpa_clist 
                  { 
                   \int_compare:nNnTF { \l_tmpa_int } = { \c_one }
                     { \MacroFont (message) ~
                       \tl_to_str:f { \token_to_str:N ##1 }\\\bottomrule
                     }
                     { \MacroFont (message) ~
                       \tl_to_str:f { \token_to_str:N ##1 }\\ 
                     }
                    \int_gdecr:N \l_tmpa_int
                   }
               \end{tabular}]
   \leavevmode\par\kern\MacroTopsep\noindent\ignorespaces
   \global\advance\c@CodelineNo\@ne
   \global\advance\c@CodelineNo\m@ne
   \ignorespaces
  }
 }
 {
  \clist_if_empty:NF \l_tmpa_clist { \endtrivlist }
 }

\def\SpecialOptIndex#1{\@bsphack
    \index{#1\actualchar{\protect\ttfamily#1}
           (option)\encapchar usage}%
    \index{options:\levelchar#1\actualchar{\protect\ttfamily#1}\encapchar
           usage}\@esphack}




%%NOT IN INDEX
%@
\DoNotIndex{\@captype,\@endparenv,\@endparpenalty,\@endpetrue,\@floatpenalty,
            \@footnotetext,\@ifnextchar,\@undefined,\@tempboxa,\@M,\@empty,
            \@height,\@mpfn,\@mpfootins,\@mpfootnotetext,\@nil,\@plus,\@width,
            \@afterheading,\@afterindentfalse,\@firstoftwo,\@gobble,
            \@ifpackageloaded,\@nobreaktrue,\@nobreakfalse,\@secondoftwo,
            \@tempa,\@tempdima}
%A
\DoNotIndex{\addpenalty,\addvspace,\advance,\afterassignment,
            \AfterEndEnvironment,\appto}
%B
\DoNotIndex{\baselineskip,\begin,\boolfalse,\begingroup,\box,
            \BeforeBeginEnvironment,\bfseries,\bgroup,\boxmaxdepth}
%C
\DoNotIndex{\color@endgroup,\color@setgroup,\columnwidth,\csdef,\c@mpfootnote,
            \csname,\clip,\color,\color@begingroup,\coordinate,\csappta,\csuse,
            \csxdef,\Currentoption}
%D
\DoNotIndex{\dimexpr,\DeclareBoolOption,\DeclareListParser,\def,\define@key,
            \dimen@,\dimen@i,\dp,\deflength,\DeclareDefaultOption,\defcounter,
            \DisableKeyvaloption}
%E
\DoNotIndex{\eject,\end,\endtrivlist,\edef,\endcsname,\endinput
            \expandafter,\endgroup,\egroup,\enlargethispage}
%F
\DoNotIndex{\fwd@reserved@a,\fwd@reserveda,\fill,\forcsvlist}
%G
\DoNotIndex{\gdef}
%H
\DoNotIndex{\hbox,\height,\hrule,\hsize,\hspace,\ht,\hb@xt@,\hss}
%I
\DoNotIndex{\if@minipage,\if@twocolumn,\if@twoside,\ifbool,\ifdim,\ifdimequal,
            \ifdimgreater,\ifdimless,\iffwd@footnoteinside,\ifinner,\ifnum,
            \ifodd,\ifblank,\ifboolexpr,\ifcase,\ifcsundef,\IfFileExists,
            \ifnumequal,\ifstrequal,\iftoggle,\ifundef,\input,
            \kernel@ifnextchar,\ifvoid,\ifx,\item}
%J
\DoNotIndex{}
%K
\DoNotIndex{\kern}
%L
\DoNotIndex{\leftline,\let,\linewidth,\lrbox,\large,\letcs,\listadd,\llap,
            \lowercase}
%M
\DoNotIndex{\maxdimen,\medskipamount,\MessageBreak,\makebox}
%N
\DoNotIndex{\NeedsTeXFormat,\newcounter,\newlength,\newrobustcmd,\nobreak,
            \normalcolor,\number,\newbool,\newcommand,\newenvironment,
            \newtheorem,\newtoggle,\node,\noindent,\notblank,\notbool,\null,
            \newpsstyle,\next}
%O
\DoNotIndex{\or}
%P
\DoNotIndex{\p@,\PackageInfo,\PackageWarning,\pagegoal,\pagetotal,\partopsep,
            \patchcmd,\penalty,\ProcessKeyvalOptions,\ProvidesPackage,
            \providecommand,\path,\protected@edef,\ProvidesFile,\psframe,
            \psline,\psset,\pst@number,\psxunit,\par,\parfillskip,\parindent,
            \PassOptionsToPackage,\pgfmathsetlengthmacro}
%Q
\DoNotIndex{}
%R
\DoNotIndex{\relax,\RequirePackage,\raggedright,\renewcommand,\rlap,\rput,\rule}
%S
\DoNotIndex{\setbox,\setkeys,\setlength,\SetupKeyvalOptions,\splitmaxdepth,
            \splittopskip,\stepcounter,\strutbox,\setbool,\settoggle,\space,
            \string}
%T
\DoNotIndex{\textwidth,\the,\thempfn,\thempfootnote,\topsep,\trivlist,\tw@,
            \tikzset}
%U
\DoNotIndex{\unskip,\unvbox}
%V
\DoNotIndex{\value,\vbox,\vfill,\vsize,\vskip,\vsplit,\vspace,\version}
%W
\DoNotIndex{\width,\wd}
%X
\DoNotIndex{\xifinlist,\xdef,\x}
%Y
\DoNotIndex{\y}
%Z
\DoNotIndex{\z@,\z@skip,\zref@addprop,\zref@extract,\zref@label,\zref@newprop,
            \zref@refused,\ZREF@mainlist}

%%%%

\tex_endinput:D

