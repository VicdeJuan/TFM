MAKE=pdflatex --interaction=batchmode
VERSION=5
EXAMEN_DIR=pdf/Examen/

all: TFM.pdf

graphs: img/*.txt
	dot -Tpng img/circuloVicioso.txt -o img/circuloVicioso.png 

R: src/*.R
	Rscript src/*.R

examen:
	@$(MAKE) $(EXAMEN_DIR)Examen.tex


TFM.pdf: examen TFM.tex tex/* img/* src/* memoria.bib
	@$(MAKE) TFM.tex; bibtex TFM; makeglossaries TFM; makeindex TFM; $(MAKE) TFM.tex; $(MAKE) TFM.tex
	cp TFM.pdf TFM_VictordeJuanV$(VERSION).pdf

bib: memoria.bib
	@bibtex TFM; $(MAKE) TFM.tex;
	
clean:
	@rm -f TFM.dvi TFM.ps *.snm *.out *.nav *.log *.aux *.toc *.vrb *.pdf *~ *.lof *.blg *.bbl *.acn *.acr *.alg *.glg *.glo *.gls *.glsdefs *.idx *.ilg *.ind *.ist *.lot *.tmp *.xdy *.fls *.fdb_latexmk
