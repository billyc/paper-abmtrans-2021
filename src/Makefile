# --------------------------------------------------
# standard Makefile preamble
# see https://tech.davis-hansson.com/p/make/
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error Your Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >
# --------------------------------------------------

TEXFILE = Paper

cur_dir = $(shell pwd)

build: build/$(TEXFILE).pdf
.PHONY: build


build/$(TEXFILE).pdf: $(shell find *)
> rm -rf build
> mkdir -p build
> pdflatex --output-directory build $(TEXFILE).tex
> BIBINPUTS=$(cur_dir):~/shared-svn/documents/inputs/bib bibtex build/$(TEXFILE)
> pdflatex --output-directory ../build $(TEXFILE).tex
> pdflatex --output-directory ../build $(TEXFILE).tex


serve:
> inotifywait -qrm --event modify src/* | while read file; do make; done
.PHONY: serve


clean:
> rm -rf $(SRC)/*.aux
> rm -rf $(SRC)/*.pdf
> rm -rf $(SRC)/*.out
> rm -rf build/*
.PHONY: clean

