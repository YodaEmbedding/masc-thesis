# Build instructions



## Simple PDF

Just run `latexmk`, which will run pdflatex with the correct options.

Done!




## Creating a PDF/A file

**NOTE:** SFU Library wants PDF/A-1b.



### Generate an easy-to-archive PDF

Some vector graphics cause trouble. So, we just convert everything to PNG.
Generate PNG assets:
```bash
cd img/
./convert_to_png.sh
```

Checkout the pdf-a branch:
```bash
git checkout pdf-a
```
This branch changes all the graphics to use the generated `png` files, and it also ensures hyperlinks are preserved using:
```latex
\usepackage[pdfa]{hyperref}
```
(Not sure if the above works with XeLaTeX, though...)

One may also consider PDF/A-1b:
```latex
\usepackage[a-1b]{pdfx}
```

Compile with XeLaTeX to ensure certain fonts are embedded. (I assume that's what was breaking the verification).




### Convert the PDF to PDF/A

Use an online tool or Ghostscript to convert the PDF to PDF/A.



#### Online tools

Convert the PDF to PDF/A using an online tool:

 - https://www.ilovepdf.com/convert-pdf-to-pdfa
 - https://xodo.com/pdf-to-pdfa
 - https://www.freepdfconvert.com/pdf-to-pdfa#cid=09xcb3izgzwnqb2w50lbnk4kv94g0tpa
 - https://www.pdf2go.com
 - https://tools.pdf24.org/en/pdf-to-pdfa (UH MASSIVE FILE, WHAT ON EARTH)
 - https://showcase.apryse.com/pdfa-conversion/  (watermark?)

These are fairly easy to use, and seem to usually generate a verapdf-verified PDF/A file.



#### Ghostscript

Convert the PDF to PDF/A using Ghostscript:

```bash
cd out/

# /bin/gs -dPDFA -dBATCH -dNOPAUSE -sColorConversionStrategy=UseDeviceIndependentColor -sDEVICE=pdfwrite -dPDFACompatibilityPolicy=2 -sOutputFile=main-pdfa.pdf main.pdf

# Or, to "preserve" hyperlinks (supposedly), though what it really does is get rid of annotations... but it works better than the above command?
/bin/gs -dPDFA -dBATCH -dNOPAUSE -sColorConversionStrategy=UseDeviceIndependentColor -sDEVICE=pdfwrite -dPDFACompatibilityPolicy=2 -dPrinted=false -sOutputFile=main-pdfa.pdf main.pdf
```

https://stackoverflow.com/questions/1659147/how-to-use-ghostscript-to-convert-pdf-to-pdf-a-or-pdf-x/56459053#56459053
https://tex.stackexchange.com/questions/245801/local-hyperlinks-broken-after-pdf-processing-with-ghostscript


Also interesting:

From https://tex.stackexchange.com/questions/456896/set-the-print-flag-on-links-with-hyperref-to-preserve-them-with-ghostscript-9

```bash
$ gs -sDEVICE=pdfwrite        \
     -dCompatibilityLevel=1.4 \
     -dPDFSETTINGS=/printer   \
     -dEmbedAllFonts=true     \
     -dSubsetFonts=true       \
     -dFastWebView=true       \
     -dNOPAUSE                \
     -dQUIET -dBATCH          \
     -sOutputFile=out.pdf     \
      in.pdf

$ gs -sDEVICE=pdfwrite         \
     -dCompatibilityLevel=1.4  \
     -dPrinted=false           \
     -dPDFSETTINGS=/printer    \
     -dEmbedAllFonts=true      \
     -dSubsetFonts=true        \
     -dFastWebView=true        \
     -dNOPAUSE -dQUIET -dBATCH \
     -sOutputFile=out.pdf      \
      in.pdf

# embed all fonts!!!!!!!!!
# subset fonts!!!!!!!!!!!!

# (subset font = embed only the characters used in the document)
# (some fonts do not license embedding everything, so you have to subset them)
# Also, subset error is what we were getting from verapdf... so probably try this too, next time!!
```

Alternative tools/links:

 - https://tex.stackexchange.com/questions/655521/how-to-produce-pdf-a-and-pdf-x-in-2022
 - https://unix.stackexchange.com/questions/79516/converting-pdf-to-pdf-a/79519#79519
 - http://thisthatisnot.blogspot.com/2013/03/freely-convert-pdfs-to-pdfa-using.html
 - https://apryse.com/blog/pdfa-format/how-to-convert-pdf-to-pdfa
 - https://wiki.archlinux.org/title/CUPS#Archival_PDF/A
 - https://webpages.tuni.fi/latex/pdfa-guide.pdf
 - https://pdfa.org/pdfa-faq/
 - https://stackoverflow.com/questions/59352679/ghostscript-lost-pdf-original-embedded-font
 - https://tex.stackexchange.com/questions/485774/how-can-i-verify-that-the-fonts-are-all-embedded-in-my-lualatex-document
 - https://stackoverflow.com/questions/1659147/how-to-use-ghostscript-to-convert-pdf-to-pdf-a-or-pdf-x/56459053#56459053
 - https://tex.stackexchange.com/questions/655521/how-to-produce-pdf-a-and-pdf-x-in-2022
 - https://tex.stackexchange.com/questions/456896/set-the-print-flag-on-links-with-hyperref-to-preserve-them-with-ghostscript-9
 - https://ctan.mirror.globo.tech/macros/latex/contrib/pdfx/pdfx.pdf



### Verifying the PDF/A file

Then, verify the PDF/A-1b file:
```bash
verapdf --flavour 1b main-pdfa.pdf
```

If this does not succeed, try to fix the issues and re-verify.




## Other attempts


### XeLaTeX

```bash
latexmk -xelatex -silent -outdir=out --halt-on-error
cp ../masc-thesis-arxiv/main.bbl out/main.bbl
latexmk -xelatex -silent -outdir=out --halt-on-error
cp ../masc-thesis-arxiv/main.bbl out/main.bbl
latexmk -xelatex -silent -outdir=out --halt-on-error
```

### LuaLaTeX

```bash
latexmk -lualatex -silent -outdir=out --halt-on-error
cp ../masc-thesis-arxiv/main.bbl out/main.bbl
latexmk -lualatex -silent -outdir=out --halt-on-error
cp ../masc-thesis-arxiv/main.bbl out/main.bbl
latexmk -lualatex -silent -outdir=out --halt-on-error
```

(Seems to not work with verapdf for some Type 1 font something).
https://tex.stackexchange.com/questions/473527/verapdf-pdf-a-1b-validation-errors


