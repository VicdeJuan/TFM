MAKE=pdflatex
VERSION=6
EXAMEN_DIR=pdf/Examen/
RETO_DIR=tex/RetoSes1/
NAME=deJuanSanz_Victor.pdf
NormalName=TFM_VictordeJuanV$(VERSION)

PRINT_INPUT=\\def\\printedVersion{}\\input{TFM.tex}
PRINT_NAME=$(NormalName)_Print.pdf

DIGITAL_INPUT=TFM.tex
DIGITAL_NAME=$(NormalName)_Digital.pdf

INPUT=TFM.tex


all: TFM

graphs: img/*.txt
	dot -Tpng img/circuloVicioso.txt -o img/circuloVicioso.png 

R: src/*.R
	Rscript src/*.R

auxpdf: RetoSes1 examen
	
RetoSes1: 
	@echo "Compilando retos..." 
	@$(MAKE) $(RETO_DIR)RetoSes1.tex
	@mv RetoSes1.pdf pdf/RetoSes1.pdf

examen: 
	@echo "Compilando examen..." 
	@$(MAKE) $(EXAMEN_DIR)Examen.tex
	@mv Examen.pdf pdf/Examen.pdf


fast:
	pdflatex TFM.tex


TFM TFM_d TFM_p: auxpdf TFM.tex tex/* img/* src/* pdf/* memoria.bib
	@echo "Compilando TFM..."
	@$(MAKE) $(INPUT) ;  	bibtex TFM  ;  	makeglossaries TFM  ;  	makeindex TFM  ;  	$(MAKE) $(INPUT)  ;  	$(MAKE) $(INPUT) ; 
	#@$(MAKE) $(INPUT) > /dev/null;  	bibtex TFM > /dev/null ;  	makeglossaries TFM > /dev/null ;  	makeindex TFM > /dev/null ;  	$(MAKE) $(INPUT) > /dev/null ;  	$(MAKE) $(INPUT) > /dev/null ; 
	

#################### Printed version ##################

printedBefore: clean1
	@echo "Compilando para imprimir...\n"
	$(eval INPUT:= $(PRINT_INPUT))


printed: printedBefore TFM_p
	cp TFM.pdf $(PRINT_NAME) 

#################### Digital version ##################

digitalBefore: clean2
	@echo "Compilando digital...\n"
	$(eval INPUT:= $(DIGITAL_INPUT))


digital: digitalBefore TFM_d
	cp TFM.pdf $(DIGITAL_NAME) 


final: 
	@mkdir -p Entrega/Imprimir Entrega/Digital/
	
	@make digital
	@cp $(DIGITAL_NAME) Entrega/Digital/$(NAME)
	@cp $(DIGITAL_NAME) Entrega
		
	@make printed
	@cp $(PRINT_NAME) Entrega/Imprimir/$(NAME)
	@cp $(PRINT_NAME) Entrega

	@cp -rv Entrega ~/Compartido/Dropbox/TFM


bib: memoria.bib
	@bibtex TFM > /dev/null ; $(MAKE) TFM.tex > /dev/null ;

clean: clean10

clean%: 
	@echo "Cleaning..."
	@rm -f TFM.dvi TFM.ps *.snm *.out *.nav *.log *.aux *.toc *.vrb *.pdf *~ *.lof *.blg *.bbl *.acn *.acr *.alg *.glg *.glo *.gls *.glsdefs *.idx *.ilg *.ind *.ist *.lot *.tmp *.xdy *.fls *.fdb_latexmk
	@rm -f $(EXAMEN_DIR)*.dvi $(EXAMEN_DIR)*.ps $(EXAMEN_DIR)*.snm $(EXAMEN_DIR)*.out $(EXAMEN_DIR)*.nav $(EXAMEN_DIR)*.log $(EXAMEN_DIR)*.aux $(EXAMEN_DIR)*.toc $(EXAMEN_DIR)*.vrb $(EXAMEN_DIR)*.pdf $(EXAMEN_DIR)*~ $(EXAMEN_DIR)*.lof $(EXAMEN_DIR)*.blg $(EXAMEN_DIR)*.bbl $(EXAMEN_DIR)*.acn $(EXAMEN_DIR)*.acr $(EXAMEN_DIR)*.alg $(EXAMEN_DIR)*.glg $(EXAMEN_DIR)*.glo $(EXAMEN_DIR)*.gls $(EXAMEN_DIR)*.glsdefs $(EXAMEN_DIR)*.idx $(EXAMEN_DIR)*.ilg $(EXAMEN_DIR)*.ind $(EXAMEN_DIR)*.ist $(EXAMEN_DIR)*.lot $(EXAMEN_DIR)*.tmp $(EXAMEN_DIR)*.xdy $(EXAMEN_DIR)*.fls $(EXAMEN_DIR)*.fdb_latexmk
	@rm -f $(RETO_DIR)*.dvi $(RETO_DIR)*.ps $(RETO_DIR)*.snm $(RETO_DIR)*.out $(RETO_DIR)*.nav $(RETO_DIR)*.log $(RETO_DIR)*.aux $(RETO_DIR)*.toc $(RETO_DIR)*.vrb $(RETO_DIR)*.pdf $(RETO_DIR)*~ $(RETO_DIR)*.lof $(RETO_DIR)*.blg $(RETO_DIR)*.bbl $(RETO_DIR)*.acn $(RETO_DIR)*.acr $(RETO_DIR)*.alg $(RETO_DIR)*.glg $(RETO_DIR)*.glo $(RETO_DIR)*.gls $(RETO_DIR)*.glsdefs $(RETO_DIR)*.idx $(RETO_DIR)*.ilg $(RETO_DIR)*.ind $(RETO_DIR)*.ist $(RETO_DIR)*.lot $(RETO_DIR)*.tmp $(RETO_DIR)*.xdy $(RETO_DIR)*.fls $(RETO_DIR)*.fdb_latexmk
	@rm -f pdf/Examen.pdf pdf/RetoSes1.pdf

#############################################################
#############################################################
#############################################################
#############################################################
#############################################################
#############################################################


debug: TFMDebug

TFMDebug: auxpdf_db examen_db TFM.tex tex/* img/* src/* memoria.bib
	@echo "Compilando TFM..."
	@$(MAKE) TFM.tex  ; bibtex TFM  ; makeglossaries TFM  ; makeindex TFM  ; $(MAKE) TFM.tex  ; $(MAKE) TFM.tex  ;
	@cp TFM.pdf $(NormalName)

examen_db: $(EXAMEN_DIR)Examen.tex
	@echo "Compilando examen..." 
	@$(MAKE) $(EXAMEN_DIR)Examen.tex
	@mv Examen.pdf pdf/Examen.pdf

RetoSes1_db:
	@echo "Compilando retos..." 
	@$(MAKE) $(RETO_DIR)RetoSes1.tex
	@mv RetoSes1.pdf pdf/RetoSes1.pdf

auxpdf_db: RetoSes1_db examen_db
