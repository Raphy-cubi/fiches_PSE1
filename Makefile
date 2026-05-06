# ============================================================
#  Fiches PSE1 — Bilan complémentaire · v0.2
#  Fichier : Makefile
#  Rôle    : Compilation des deux fiches (A3 et A4) à partir de
#            main.tex. Auxiliaires dans build/, PDFs finaux dans
#            output/. Cibles : make a3 / make a4 / make all / make clean.
# ============================================================

BUILDDIR := build
OUTDIR   := output
LATEX    := pdflatex -interaction=nonstopmode -synctex=1 -output-directory=$(BUILDDIR)

.PHONY: all a3 a4 clean

# Cible par défaut : produit les deux PDFs
all: a3 a4

# Création des dossiers à la demande
$(BUILDDIR) $(OUTDIR):
	@mkdir -p $@

# A3 : on injecte \def\PaperFormat{A3} en pretex puis on déplace le PDF
a3: | $(BUILDDIR) $(OUTDIR)
	$(LATEX) -jobname=bilan_A3 "\def\PaperFormat{A3}\input{main}"
	$(LATEX) -jobname=bilan_A3 "\def\PaperFormat{A3}\input{main}"
	@mv $(BUILDDIR)/bilan_A3.pdf $(OUTDIR)/bilan_A3.pdf

# A4 : pas de pretex, A4 est le format par défaut de main.tex
a4: | $(BUILDDIR) $(OUTDIR)
	$(LATEX) -jobname=bilan_A4 main.tex
	$(LATEX) -jobname=bilan_A4 main.tex
	@mv $(BUILDDIR)/bilan_A4.pdf $(OUTDIR)/bilan_A4.pdf

# Suppression de tous les artefacts générés (auxiliaires + PDFs)
clean:
	rm -rf $(BUILDDIR)
	rm -f $(OUTDIR)/*.pdf
