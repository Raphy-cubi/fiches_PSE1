# Fiches PSE1 — Bilan complémentaire

Fiche LaTeX du **bilan complémentaire (4e regard)** pour le PSE1 (Premiers
Secours en Équipe niveau 1). Une seule source produit deux PDFs prêts à
être imprimés et plastifiés (feutre effaçable) :

- `output/bilan_A3.pdf` — A3 paysage, version confortable
- `output/bilan_A4.pdf` — A4 paysage, version compacte

## Contenu de la fiche

- Bandeau identité (Nom, Âge, Sexe, Taille, Poids, Heure, Adresse, contact)
- Mécanisme & Anamnèse — PQRST, SAMPLE V, MATH F
- Rappel 2e regard — XABCD
- Bilan respiratoire — FARASS + O₂ / Masque
- Bilan circulatoire — FARATT + Température
- Bilan neurologique — OMSPGG, FAST, rappel Glasgow, rappel EVDA
- Gestes effectués (LVAS, ACR, traumatismes, plaies, positions)
- Tableau de surveillance dans le temps

## Compilation

### Avec `make` (Linux/macOS, ou Windows + WSL/Make)

```sh
make a4      # A4 seulement
make a3      # A3 seulement
make all     # les deux
make clean   # nettoie build/ et output/
```

### Avec VSCode + LaTeX Workshop

Ouvrir le projet : la recipe par défaut **« Build A3+A4 »** se déclenche
au save (`autoBuild.run = onSave`) et produit les deux PDFs dans
`output/`. Les recipes alternatives **« A3 only »** et **« A4 only »**
sont disponibles via la palette de commandes.

### Avec `pdflatex` direct

```sh
# A4 (format par défaut)
pdflatex -output-directory=build -jobname=bilan_A4 main.tex

# A3
pdflatex -output-directory=build -jobname=bilan_A3 \
  "\def\PaperFormat{A3}\input{main}"
```

## Structure du projet

```
fiches_PSE1/
├── main.tex                      Point d'entrée unique
├── inc/
│   ├── packages.tex              \usepackage
│   ├── colors.tex                Palette PSE
│   └── commands.tex              \acronymfield*, \opt, \sev, \blocktitle, \ifA
├── src/sections/
│   ├── header.tex                Bandeau identité victime
│   ├── mecanisme.tex             Mécanisme & Anamnèse
│   ├── xabcd.tex                 Rappel 2e regard XABCD
│   ├── respiration.tex           FARASS
│   ├── circulation.tex           FARATT
│   ├── neurologie.tex            OMSPGG + FAST + Glasgow + EVDA
│   ├── gestes.tex                Gestes effectués
│   └── surveillance.tex          Tableau de surveillance
├── output/                       PDFs finaux (suivis dans git)
├── build/                        Auxiliaires (gitignoré)
├── fiches/                       Source legacy v0.1 conservée
├── _dump/                        Script de snapshot pour partage IA
├── Makefile / .latexmkrc / .vscode/settings.json
└── README.md
```

## Mécanique A3/A4

`main.tex` lit la macro `\PaperFormat` (par défaut `A4`). Les commandes
de `inc/commands.tex` ont deux variantes (`...A` pour A3, `...B` pour
A4) et un dispatch les lie aux noms publics. Dans les sections, la
macro `\ifA{...A3...}{...A4...}` permet des conditionnels inline pour
les écarts spécifiques (paddings, largeurs de colonnes, etc.).
