all: TFM.pdf

TFM.pdf: TFM.tex
	pdflatex TFM.tex; bibtex TFM; makeglossaries TFM; makeindex TFM; pdflatex TFM.tex; pdflatex TFM.tex

clean:
	rm -f TFM.dvi TFM.ps *.snm *.out *.nav *.log *.aux *.toc *.vrb *.pdf *~ *.lof *.blg *.bbl
