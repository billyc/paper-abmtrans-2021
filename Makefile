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

build: build/paper.pdf
.PHONY: build


build/paper.pdf: $(shell find src/*) Makefile
> rm -rf build
> mkdir -p build
> cd src
> pdflatex --output-directory ../build paper.tex
> pdflatex --output-directory ../build paper.tex


serve:
> inotifywait -qrm --event modify src/* | while read file; do make; done
.PHONY: serve


clean:
> rm -rf src/*.aux
> rm -rf src/*.pdf
> rm -rf src/*.out
> rm -rf build/*
.PHONY: clean

