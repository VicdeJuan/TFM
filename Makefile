all: TFM.pdf

MAKE=pdflatex --interaction=batchmode

graphs: img/*.txt
	dot -Tpng img/circuloVicioso.txt -o img/circuloVicioso.png 

R: src/*.R
	Rscript src/*.R


TFM.pdf: TFM.tex tex/* img/* src/* memoria.bib
	@$(MAKE) TFM.tex; bibtex TFM; makeglossaries TFM; makeindex TFM; $(MAKE) TFM.tex; $(MAKE) TFM.tex

bib: memoria.bib
	@bibtex TFM; $(MAKE) TFM.tex;
	
clean:
	@rm -f TFM.dvi TFM.ps *.snm *.out *.nav *.log *.aux *.toc *.vrb *.pdf *~ *.lof *.blg *.bbl *.acn *.acr *.alg *.glg *.glo *.gls *.glsdefs *.idx *.ilg *.ind *.ist *.lot *.tmp *.xdy *.fls *.fdb_latexmk
