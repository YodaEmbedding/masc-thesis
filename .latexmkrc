$out_dir = "out";
$pdf_mode = 1;  # 1 == generate pdf via pdflatex; equivalent to latexmk -pdf
$recorder = 1;  # .fls file containing list of files that are R/W.  # Already true by default?
$bibtex_use = 2;  # 1 == only use BibTeX or biber if the bib files exist. 2 == run BibTeX or biber whenever it appears necessary to update the bbl files, without testing for the existence of the bib files

$pdflatex_opts = "--shell-escape --halt-on-error";
$pdflatex = "pdflatex $pdflatex_opts %O %S";
