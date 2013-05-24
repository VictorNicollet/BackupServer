all:
	ocamlbuild -use-ocamlfind main.byte
	chmod a+x run