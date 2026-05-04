OUTDIR = output
LATEX  = pdflatex -output-directory=$(OUTDIR) -interaction=nonstopmode

.PHONY: all a3 a4 clean

all: a3 a4

a3:
	$(LATEX) bilan_complementaire_A3.tex
	$(LATEX) bilan_complementaire_A3.tex

a4:
	$(LATEX) bilan_complementaire_A4.tex
	$(LATEX) bilan_complementaire_A4.tex

clean:
	rm -f $(OUTDIR)/*.aux $(OUTDIR)/*.log $(OUTDIR)/*.out
