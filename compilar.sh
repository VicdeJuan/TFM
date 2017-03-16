#!/bin/bash

# Limpiar archivos auxiliares
#./limpiar.sh

main="TFM"

# Compilar
pdflatex $main
bibtex $main
makeglossaries $main
makeindex $main
pdflatex $main
pdflatex $main
#mv $main.pdf "Trabajo de Fin de Grado.pdf"

# Limpiar archivos auxiliares
#./limpiar.sh
