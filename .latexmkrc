# ============================================================
#  Fiches PSE1 — Bilan complémentaire · v0.2
#  Fichier : .latexmkrc
#  Rôle    : Config par défaut de latexmk : pdfLaTeX, auxiliaires
#            dans build/. La production simultanée A3 + A4 est
#            gérée par le Makefile et les recipes VSCode (latexmk
#            n'expose pas de "deux PDFs en un seul source" natif).
# ============================================================

$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
$out_dir  = 'build';
@default_files = ('main.tex');
$clean_ext = "synctex.gz aux log fls fdb_latexmk out toc nav snm vrb";
