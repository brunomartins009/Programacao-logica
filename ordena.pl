/*--------------------------------------------------------------------------------
 * Ordenação
Escolher dois métodos de ordenação apresentados em aula (inserção, troca, seleção ou quicksort)
e modificar para realizar ordenação em ordem decrescente.

14/08/2022

Data			: 14/08/2022
Disciplina   	: Programação Lógica
Prof.        	: Luiz Eduardo da Silva
Aluno			: Bruno Martins Cordeiro
Matrícula		: 2020.1.08.006
--------------------------------------------------------------------------------*/
ap([],L,L).
ap([A|B], C, [A|D]) :- ap(B,C,D).

troca(L,S) :-
	ap(X,[A,B|C],L), B > A, !,
	ap(X,[B,A|C],Li),
	troca(Li,S).
troca(L,L).

particao([X|L], Pivo, [X|Menores], Maiores) :-
	X > Pivo, !, particao(L,Pivo, Menores, Maiores).
particao([X|L], Pivo, Menores,[X|Maiores]) :-
	X =< Pivo, !, particao(L, Pivo, Menores, Maiores).
particao([],_,[],[]).

quickSort([A|B], S) :-
	particao(B,A,Me,Ma),
	quickSort(Me, MeOrd),
	quickSort(Ma, MaOrd),
	ap(MeOrd, [A|MaOrd], S).
quickSort([],[]).