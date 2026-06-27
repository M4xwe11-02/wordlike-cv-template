TARGET_ZH = resume-zh
TARGET_EN = resume-en
LATEX = xelatex
LATEX_FLAGS = -interaction=nonstopmode

.PHONY: all zh en clean

all: zh en

zh: $(TARGET_ZH).pdf

en: $(TARGET_EN).pdf

$(TARGET_ZH).pdf: $(TARGET_ZH).tex style/cv-style.tex content/zh/*.tex
	$(LATEX) $(LATEX_FLAGS) $(TARGET_ZH).tex
	$(LATEX) $(LATEX_FLAGS) $(TARGET_ZH).tex

$(TARGET_EN).pdf: $(TARGET_EN).tex style/cv-style.tex content/en/*.tex
	$(LATEX) $(LATEX_FLAGS) $(TARGET_EN).tex
	$(LATEX) $(LATEX_FLAGS) $(TARGET_EN).tex

clean:
	rm -f *.aux *.log *.out *.xdv *.fls *.fdb_latexmk *.synctex.gz $(TARGET_ZH).pdf $(TARGET_EN).pdf
