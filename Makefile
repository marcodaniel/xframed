################################################################
## Makefile for xframed project folder
## $Id: Makefile 6 2012-05-28 18:46:06Z marco $
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
CLASS     = ltxmdf
EXAMPLE   = xframed-example
STYLE_I   = md-frame-0
STYLE_II  = md-frame-1
STYLE_III = md-frame-2
STYLE_IV  = md-frame-3
FILELIST  =  $(PACKAGE) $(EXAMPLE) 
STYLELIST = 
AUXFILES  = aux dtxe glo glolog gls hd ins idx idxlog ilg ind log \
            out ps thm tmp toc 
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
	@echo -e "$(OK_COLOR)\tmake all\t\t--\trun docsty examples clean"
	@echo -e "\tmake examples\t\t--\tcompiles all example files"
	@echo -e "\tmake clean\t\t--\tremove all helpfiles created by xframed"
	@echo -e "\tmake changeversion\t--\tmaintaner tool to change the version"
	@echo -e "\tmake localinstall\t--\tinstall the package in TEXMFHOME"
	@echo -e "$(WARN_COLOR)End help$(NO_COLOR)"

################################################################
## Compilation
################################################################
%.pdf: %.tex
	NAME=`basename $< .tex` ;\
	echo -e "" ;\
	echo -e "\t$(WARN_COLOR)Typesetting $$NAME$(NO_COLOR)" ;\
	pdflatex -draftmode -interaction=nonstopmode $< > /dev/null ;\
	if [ $$? = 0 ] ; then \
	  echo -e "\t$(OK_COLOR)compilation in draftmode without erros$(NO_COLOR)" ;\
	  echo -e "\t$(OK_COLOR)Run PDFLaTeX again on $$NAME.tex$(NO_COLOR)" ;\
	  pdflatex -interaction=nonstopmode $< > /dev/null ;\
	else \
	  echo -e "\t$(ERROR_COLOR)compilation in draftmode with erros$(NO_COLOR)" ;\
	  exit 0;\
	fi ;\
	echo -e "\t$(OK_COLOR)Typesetting $$NAME finished $(NO_COLOR)" ;\


################################################################
## Compilation
################################################################
docsty: $(PACKAGE).dtx
	echo -e "" ;\
	echo -e "\t$(WARN_COLOR)Typesetting $(PACKAGE).dtx$(NO_COLOR)" ;\
	pdflatex -draftmode -interaction=nonstopmode $(PACKAGE).dtx > /dev/null ;\
	if [ $$? = 0 ] ; then \
	  echo -e "\t$(OK_COLOR)compilation in draftmode without erros$(NO_COLOR)" ;\
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
	  pdflatex $(PACKAGE).dtx > /dev/null ;\
	  if [ $$? = 0 ] ; then \
	     echo -e "\t$(OK_COLOR)Second pdflatex compilation without erros$(NO_COLOR)" ;\
	  else \
	     echo -e "\t$(ERROR_COLOR)Second pdflatex compilation with erros$(NO_COLOR)" ;\
	     exit 0;\
	  fi ;\
	  pdflatex $(PACKAGE).dtx > /dev/null ;\
	else \
	  echo -e "\t$(ERROR_COLOR)compilation in draftmode with erros$(NO_COLOR)" ;\
	  exit 0;\
	fi ;\

example: $(EXAMPLE).pdf

clean:  
	echo  "" ;\
	echo -e "\t$(WARN_COLOR)Start removing help files$(NO_COLOR)" ;\
	for I in $(FILELIST) ;\
	do \
	  for J in $(AUXFILES) ;\
	  do \
	    rm -rf $$I.$$J ;\
	  done ;\
	done ;\
	echo -e "\t$(OK_COLOR)Removing finished$(NO_COLOR)" ;\

all:	docsty examples clean

################################################################
## personal setting
################################################################
localinstall:	docsty examples makelocalinstall clean

makelocalinstall:
	echo  "" ;\
	echo -e "\t$(ERROR_COLOR)Start local install$(NO_COLOR)" ;\
	PATHTEXHOME=`kpsewhich --var-value=TEXMFHOME` ;\
	echo -e "\t$(ERROR_COLOR)Creating folders if don't exist$(NO_COLOR)" ;\
	mkdir -p $$PATHTEXHOME/doc/latex/$(PACKAGE)/ ;\
	mkdir -p $$PATHTEXHOME/tex/latex/$(PACKAGE)/ ;\
	for I in $(FILELIST) ;\
	do \
	  cp $$I.pdf $$PATHTEXHOME/doc/latex/$(PACKAGE)/  ;\
	done ;\
	for I in $(STYLELIST) ;\
	do \
	  cp $$I.mdf $$PATHTEXHOME/tex/latex/$(PACKAGE)/  ;\
	done ;\
	cp $(PACKAGE).sty $$PATHTEXHOME/tex/latex/$(PACKAGE)/  ;\
	cp $(CLASS).cls $$PATHTEXHOME/tex/latex/$(PACKAGE)/  ;\
	echo -e "\t$(OK_COLOR)Installation done$(NO_COLOR)" ;\

################################################################
## maintaner tool
################################################################
changeversion:
	@echo 
	@echo -e "$(OK_COLOR)Aktuell wird die folgende Version verwendet"
	@sed '/\\def\\mdversion/!d' $(PACKAGE).sty 
	@echo -e "$(WARN_COLOR)"
	@read -p "Bitte neue Version eingeben: " REPLY &&  sed -rie "s/(\\\\def\\\\mdversion\{).*(})/\1$$REPLY\2/" $(PACKAGE).dtx&&\
	 echo -e "$(OK_COLOR)Version geändert zu $$REPLY$(NO_COLOR)"
	@echo

usectanify:
	echo  "" ;\
	echo -e "\t$(ERROR_COLOR)Start ctanify$(NO_COLOR)" ;\
	ctanify $(PACKAGE).ins $(PACKAGE).pdf README.txt $(CLASS).cls \
	        $(EXAMPLE).tex=doc/latex/$(PACKAGE)/ \
	        $(EXAMPLE).pdf=doc/latex/$(PACKAGE)/ \
	        Makefile=source/latex/$(PACKAGE)/ \
	if [ $$? = 0 ] ; then \
	     echo -e "\t$(OK_COLOR)ctanify without errors$(NO_COLOR)" ;\
	     echo -e "" ;\
	else \
	  echo -e "\t$(ERROR_COLOR)ctanify with erros$(NO_COLOR)" ;\
	  exit 0;\
	fi ;\

ctan: docsty example usectanify clean
