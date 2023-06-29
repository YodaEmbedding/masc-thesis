default: out/main.pdf

.PHONY: clean
clean:
	rm -rf out/

.PHONY: mkdirs
mkdirs:
	find "tex" -type d ! -path './.git*' ! -path '*/out*' -exec mkdir -p "out/{}" \;
	mkdir -p out/out

.PHONY: monitor
monitor: mkdirs
	latexmk -pvc -view=none -interaction=nonstopmode main.tex

out/main.pdf: main.tex mkdirs
	latexmk $<
