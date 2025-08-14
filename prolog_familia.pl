%	Esquema de arvore genealogica em prolog

pai("Juscelino", "Eliseu").
pai("Abel", "Lucia").
pai("Eliseu", "Bruno").
pai("Eliseu", "Yasmin").

mae("rosa c", "Eliseu").
mae("rosa m", "Lucia").
mae("Lucia", "Bruno").
mae("Lucia", "Yasmin").

tem_filho(X) :- pai(X,_).

avo(A, C) :- pai(B, C), pai(A, B).
avo(A, C) :- pai(A, B), mae(B, C).

avoh(A, C) :- mae(A, B), pai(B, C).
avoh(A, C) :- mae(A, B), mae(B, C).

antecessor(X, Y) :- pai(X, Y).
antecessor(X, Y) :- mae(X, Y).
antecessor(X, Y) :- pai(X, Z), antecessor(Z, Y).
antecessor(X, Y) :- mae(X, Z), antecessor(Z, Y).