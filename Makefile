### Makefile		Created      : Sat Feb  8 21:56:05 2003
###			Last modified: Sat Dec 24 20:31:11 2016
OCAMLMAKEFILE=./OcamlMakefile
SOURCES=url.ml http.ml main.ml
RESULT=http
OCAMLC=ocamlfind ocamlc -g
LIBS=str unix

include $(OCAMLMAKEFILE)
