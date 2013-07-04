################################################################
## Makefile for mdframed project folder
## $Id: Makefile 428 2012-06-06 12:30:18Z marco $
################################################################
## Definitions
################################################################
.SILENT:
SHELL     := /bin/bash
.PHONY: all clean ctan allwithoutclean
################################################################
## Name list
################################################################
PACKAGE   = xframed
DEFLIST   = default dev dim funct initial keys listings mdframed minted msg split theorem tikz titlefoot todo user
AUXFILES  = aux dtxe glo glolog gls hd idx idxlog ilg ind log out ps pyg thm tmp toc xdv
ENGINE    = lualatex


################################################################
## Colordefinition
################################################################
NO_COLOR    = \x1b[0m
OK_COLOR    = \x1b[32;01m
WARN_COLOR  = \x1b[33;01m
ERROR_COLOR = \x1b[31;01m
################################################################
## make help
################################################################
help:
	@echo 
	@echo -e "$(WARN_COLOR)The following definitions provided by this Makefile"
	@echo -e "$(OK_COLOR)\tmake docsty\t\t--\ttypesets the documenation and the package"
	@echo -e "$(OK_COLOR)\tmake docstydevel\t--\ttypesets the code documenation and the package"
	@echo -e "$(OK_COLOR)\tmake all\t\t--\trun docsty docstydevel clean"
	@echo -e "\tmake clean\t\t--\tremove all helpfiles created by mdframed"
	@echo -e "\tmake changeversion\t--\tmaintaner tool to change the version"
	@echo -e "\tmake changerevision\t--\tmaintaner tool to change the revision"
	@echo -e "\tmake changedate\t\t--\tmaintaner tool to change the date"
	@echo -e "\tmake change\t\t--\trun changeversion changerevision changedate"
	@echo -e "\tmake localinstall\t--\tinstall the package in TEXMFHOME"
	@echo -e "$(WARN_COLOR)End help$(NO_COLOR)"

################################################################
## Compilation "\def\myvar{info-to-pass} \input{<filename>}"
################################################################
docsty: $(PACKAGE).dtx
	echo -e "" ;\
	echo -e "\t$(WARN_COLOR)Typesetting $(PACKAGE).dtx$(NO_COLOR)" ;\
	$(ENGINE) --draftmode --interaction=nonstopmode --shell-escape "\let\ifdevel\iffalse \input{$(PACKAGE).dtx}" > /dev/null ;\
	if [ $$? = 0 ] ; then \
	  echo -e "\t$(OK_COLOR)compilation in draftmode without errors$(NO_COLOR)" ;\
	  if [ -f $(PACKAGE).glo ] ; then \
	   echo -e "\t$(WARN_COLOR)Typesetting $(PACKAGE).glo$(NO_COLOR)" ;\
	   makeindex -q -t $(PACKAGE).glolog  -s gglo.ist -o $(PACKAGE).gls $(PACKAGE).glo ;\
	   if [ $$? = 0 ] ; then \
	     echo -e "\t$(OK_COLOR)compilation of Glossar without errors$(NO_COLOR)" ;\
	   else \
	     echo -e "\t$(ERROR_COLOR)compilation of Glossar with errors$(NO_COLOR)" ;\
	   fi ;\
	  fi ;\
	  if [ -f $(PACKAGE).idx ] ; then \
	   echo -e "\t$(WARN_COLOR)Typesetting $(PACKAGE).idx$(NO_COLOR)" ;\
	   makeindex -q -t $(PACKAGE).idxlog -s gind.ist $(PACKAGE).idx ;\
	   if [ $$? = 0 ] ; then \
	     echo -e "\t$(OK_COLOR)compilation of Index without errors$(NO_COLOR)" ;\
	   else \
	     echo -e "\t$(ERROR_COLOR)compilation of Index with errors$(NO_COLOR)" ;\
	   fi ;\
	  fi ;\
	  $(ENGINE) --shell-escape "\let\ifdevel\iffalse \input{$(PACKAGE).dtx}" > /dev/null ;\
	  if [ $$? = 0 ] ; then \
	     echo -e "\t$(OK_COLOR)Second $(ENGINE) compilation without errors$(NO_COLOR)" ;\
		 echo -e "\t$(OK_COLOR)Start third $(ENGINE) compilation$(NO_COLOR)" ;\
		 $(ENGINE) --shell-escape "\let\ifdevel\iffalse \input{$(PACKAGE).dtx}" > /dev/null ;\
	     echo -e "\t$(OK_COLOR)Done.$(NO_COLOR)" ;\
	  else \
	     echo -e "\t$(ERROR_COLOR)Second $(ENGINE) compilation with errors$(NO_COLOR)" ;\
	     exit 0;\
	  fi ;\
	else \
	  echo -e "\t$(ERROR_COLOR)compilation in draftmode with errors$(NO_COLOR)" ;\
	  exit 0;\
	fi ;\

docstydevel: $(PACKAGE).dtx
	echo -e "" ;\
	echo -e "\t$(WARN_COLOR)Typesetting $(PACKAGE).dtx$  -- devel version$(NO_COLOR)" ;\
	$(ENGINE) --draftmode --interaction=nonstopmode --shell-escape --jobname=$(PACKAGE)-devel "\def\jobname{xframed}\let\ifdevel\iftrue \input{$(PACKAGE).dtx}" > /dev/null ;\
	if [ $$? = 0 ] ; then \
	  echo -e "\t$(OK_COLOR)compilation in draftmode without errors$(NO_COLOR)" ;\
	  if [ -f $(PACKAGE).glo ] ; then \
	   echo -e "\t$(WARN_COLOR)Typesetting $(PACKAGE).glo$(NO_COLOR)" ;\
	   makeindex -q -t $(PACKAGE).glolog  -s gglo.ist -o $(PACKAGE).gls $(PACKAGE).glo ;\
	   if [ $$? = 0 ] ; then \
	     echo -e "\t$(OK_COLOR)compilation of Glossar without errors$(NO_COLOR)" ;\
	   else \
	     echo -e "\t$(ERROR_COLOR)compilation of Glossar with errors$(NO_COLOR)" ;\
	   fi ;\
	  fi ;\
	  if [ -f $(PACKAGE).idx ] ; then \
	   echo -e "\t$(WARN_COLOR)Typesetting $(PACKAGE).idx$(NO_COLOR)" ;\
	   makeindex -q -t $(PACKAGE).idxlog -s gind.ist $(PACKAGE).idx ;\
	   if [ $$? = 0 ] ; then \
	     echo -e "\t$(OK_COLOR)compilation of Index without errors$(NO_COLOR)" ;\
	   else \
	     echo -e "\t$(ERROR_COLOR)compilation of Index with errors$(NO_COLOR)" ;\
	   fi ;\
	  fi ;\
	  $(ENGINE) --shell-escape --jobname=$(PACKAGE)-devel "\def\jobname{xframed}\let\ifdevel\iftrue \input{$(PACKAGE).dtx}" > /dev/null ;\
	  $(ENGINE) --shell-escape --jobname=$(PACKAGE)-devel "\def\jobname{xframed}\let\ifdevel\iftrue \input{$(PACKAGE).dtx}" > /dev/null ;\
	  if [ $$? = 0 ] ; then \
	     echo -e "\t$(OK_COLOR)Second $(ENGINE) compilation without errors$(NO_COLOR)" ;\
	  else \
	     echo -e "\t$(ERROR_COLOR)Second $(ENGINE) compilation with errors$(NO_COLOR)" ;\
	     exit 0;\
	  fi ;\
	else \
	  echo -e "\t$(ERROR_COLOR)compilation in draftmode with errors$(NO_COLOR)" ;\
	  exit 0;\
	fi ;\

clean:  
	echo  "" ;\
	echo -e "\t$(WARN_COLOR)Start removing help files$(NO_COLOR)" ;\
	for J in $(AUXFILES) ;\
	  do \
	    rm -rf $(PACKAGE)*.$$J ;\
	  done ;\
	echo -e "\t$(OK_COLOR)Removing finished$(NO_COLOR)" ;\

all:	docsty docstydevel clean

################################################################
## personal setting
################################################################
localinstall:	docsty docstydevel makelocalinstall clean

makelocalinstall:
	echo  "" ;\
	echo -e "\t$(ERROR_COLOR)Start local install$(NO_COLOR)" ;\
	PATHTEXHOME=`kpsewhich --var-value=TEXMFHOME` ;\
	echo -e "\t$(ERROR_COLOR)Creating folders if don't exist$(NO_COLOR)" ;\
	mkdir -p $$PATHTEXHOME/doc/latex/$(PACKAGE)/ ;\
	mkdir -p $$PATHTEXHOME/tex/latex/$(PACKAGE)/ ;\
	cp $(PACKAGE).pdf $$PATHTEXHOME/doc/latex/$(PACKAGE)/  ;\
	cp $(PACKAGE)-devel.pdf $$PATHTEXHOME/doc/latex/$(PACKAGE)/  ;\
	for I in $(DEFLIST) ;\
	do \
	  cp $(PACKAGE)-$$I.def $$PATHTEXHOME/tex/latex/$(PACKAGE)/  ;\
	done ;\
	cp $(PACKAGE).sty $$PATHTEXHOME/tex/latex/$(PACKAGE)/  ;\
	echo -e "\t$(OK_COLOR)Installation done$(NO_COLOR)" ;\

################################################################
## maintainer tool
################################################################
changeversion:
	@echo 
	@echo -e "$(OK_COLOR)Aktuell wird die folgende Version verwendet"
	@sed '/\\def\\mdversion/!d' $(PACKAGE).sty 
	@echo -e "$(WARN_COLOR)"
	@read -p "Bitte neue Version eingeben: " REPLY &&  sed -Eie "s/(\\\\def\\\\mdversion\{).*(})/\1$$REPLY\2/" $(PACKAGE).dtx&&\
	 echo -e "$(OK_COLOR)Version geändert zu $$REPLY$(NO_COLOR)"
	@echo

changerevision:
	@echo 
	@echo -e "$(OK_COLOR)Aktuell wird die folgende Revision verwendet"
	@sed '/\\def\\mdfrevision/!d' $(PACKAGE).dtx 
	@echo -e "$(WARN_COLOR)"
	@REPLY=`git rev-list HEAD | wc -l` &&  sed -Eie "s/(\\\\def\\\\mdfrevision\{).*(})/\1$$REPLY\2/" $(PACKAGE).dtx&&\
	 echo -e "$(OK_COLOR)Revision geändert zu $$REPLY$(NO_COLOR)"
	@echo

changedate:
	@echo 
	@echo -e "$(OK_COLOR)Aktuell wird die folgendes Datum verwendet"
	@sed '/\\def\\mdfmaindate/!d' $(PACKAGE).dtx 
	@echo -e "$(WARN_COLOR)"
	@REPLY=`date +"%Y\/%m\/%d"` &&  sed -Eie "s/(\\\\def\\\\mdfmaindate\{).*(})/\1$$REPLY\2/" $(PACKAGE).dtx&&\
	 echo -e "$(OK_COLOR)Datum geändert zu $$REPLY$(NO_COLOR)"
	@echo

change: changeversion changerevision changedate

usectanify:
	echo  "" ;\
	echo -e "\t$(ERROR_COLOR)Start ctanify$(NO_COLOR)" ;\
	ctanify $(PACKAGE).ins $(PACKAGE).pdf
	if [ $$? = 0 ] ; then \
	     echo -e "\t$(OK_COLOR)ctanify without errors$(NO_COLOR)" ;\
	     echo -e "" ;\
	else \
	  echo -e "\t$(ERROR_COLOR)ctanify with errors$(NO_COLOR)" ;\
	  exit 0;\
	fi ;\

ctan: docsty usectanify clean
