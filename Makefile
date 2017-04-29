all: TFM.pdf

graphs: img/*.txt
	dot -Tpng circuloVicioso.txt -o circuloVicioso.png 

R: src/*.R
	Rscript src/*.R


TFM.pdf: TFM.tex tex/* img/* src/* memoria.bib
	pdflatex TFM.tex; bibtex TFM; makeglossaries TFM; makeindex TFM; pdflatex TFM.tex; pdflatex TFM.tex

bib: memoria.bib
	bibtex TFM; pdflatex TFM.tex;
	
clean:
	rm -f TFM.dvi TFM.ps *.snm *.out *.nav *.log *.aux *.toc *.vrb *.pdf *~ *.lof *.blg *.bbl *.acn *.acr *.alg *.glg *.glo *.gls *.glsdefs *.idx *.ilg *.ind *.ist *.lot *.tmp *.xdy
