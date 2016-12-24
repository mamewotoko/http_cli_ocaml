### Makefile		Created      : Sat Feb  8 21:56:05 2003
###			Last modified: Sat Dec 24 21:12:35 2016
OCAMLMAKEFILE=./OCamlMakefile
SOURCES=url.ml http.ml main.ml
RESULT=http
OCAMLC=ocamlfind ocamlc -g
LIBS=str unix

include $(OCAMLMAKEFILE)
