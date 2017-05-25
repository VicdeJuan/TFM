MAKE=pdflatex 
VERSION=6
EXAMEN_DIR=pdf/Examen/
NAME=deJuanSanz_Victor.pdf


all: TFM.pdf

graphs: img/*.txt
	dot -Tpng img/circuloVicioso.txt -o img/circuloVicioso.png 

R: src/*.R
	Rscript src/*.R

examen: $(EXAMEN_DIR)Examen.tex
	@echo "Compilando examen..." 
	@$(MAKE) $(EXAMEN_DIR)Examen.tex > /dev/null
	@mv Examen.pdf pdf/Examen.pdf

retos: RetoSes1
	
RetoSes1:
	@echo "Compilando retos..." 
	@$(MAKE) tex/RetoSes1/RetoSes1.tex > /dev/null
	@mv RetoSes1.pdf pdf/RetoSes1.pdf

fast:
	pdflatex TFM.tex

TFM.pdf: retos examen TFM.tex tex/* img/* src/* memoria.bib
	@echo "Compilando TFM..."
	@$(MAKE) TFM.tex >/dev/null ; bibtex TFM > /dev/null ; makeglossaries TFM > /dev/null ; makeindex TFM > /dev/null ; $(MAKE) TFM.tex > /dev/null ; $(MAKE) TFM.tex > /dev/null ;
	@cp TFM.pdf TFM_VictordeJuanV$(VERSION).pdf
	
final:
	@cp TFM.pdf $(NAME)
	@cp $(NAME) ~/Compartido/Dropbox/TFM

bib: memoria.bib
	@bibtex TFM > /dev/null ; $(MAKE) TFM.tex > /dev/null ;
	
clean:
	@rm -f TFM.dvi TFM.ps *.snm *.out *.nav *.log *.aux *.toc *.vrb *.pdf *~ *.lof *.blg *.bbl *.acn *.acr *.alg *.glg *.glo *.gls *.glsdefs *.idx *.ilg *.ind *.ist *.lot *.tmp *.xdy *.fls *.fdb_latexmk
	@rm -f $(EXAMEN_DIR)*.dvi $(EXAMEN_DIR)*.ps $(EXAMEN_DIR)*.snm $(EXAMEN_DIR)*.out $(EXAMEN_DIR)*.nav $(EXAMEN_DIR)*.log $(EXAMEN_DIR)*.aux $(EXAMEN_DIR)*.toc $(EXAMEN_DIR)*.vrb $(EXAMEN_DIR)*.pdf $(EXAMEN_DIR)*~ $(EXAMEN_DIR)*.lof $(EXAMEN_DIR)*.blg $(EXAMEN_DIR)*.bbl $(EXAMEN_DIR)*.acn $(EXAMEN_DIR)*.acr $(EXAMEN_DIR)*.alg $(EXAMEN_DIR)*.glg $(EXAMEN_DIR)*.glo $(EXAMEN_DIR)*.gls $(EXAMEN_DIR)*.glsdefs $(EXAMEN_DIR)*.idx $(EXAMEN_DIR)*.ilg $(EXAMEN_DIR)*.ind $(EXAMEN_DIR)*.ist $(EXAMEN_DIR)*.lot $(EXAMEN_DIR)*.tmp $(EXAMEN_DIR)*.xdy $(EXAMEN_DIR)*.fls $(EXAMEN_DIR)*.fdb_latexmk


#############################################################
#############################################################
#############################################################
#############################################################
#############################################################
#############################################################


debug: TFMDebug

TFMDebug: retos_db examen_db TFM.tex tex/* img/* src/* memoria.bib
	@echo "Compilando TFM..."
	@$(MAKE) TFM.tex  ; bibtex TFM  ; makeglossaries TFM  ; makeindex TFM  ; $(MAKE) TFM.tex  ; $(MAKE) TFM.tex  ;
	@cp TFM.pdf TFM_VictordeJuanV$(VERSION).pdf

examen_db: $(EXAMEN_DIR)Examen.tex
	@echo "Compilando examen..." 
	@$(MAKE) $(EXAMEN_DIR)Examen.tex
	@mv Examen.pdf pdf/Examen.pdf

retos_db: RetoSes1_db
	
RetoSes1_db:
	@echo "Compilando retos..." 
	@$(MAKE) tex/RetoSes1/RetoSes1.tex
	@mv RetoSes1.pdf pdf/RetoSes1.pdf
