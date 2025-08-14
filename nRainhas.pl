% :- use_rendering(chess).
% A solucao: X = [2, 4, 1, 3], deverá ser apresentada como: 
% 				 [[_,r,_,_],[_,_,_,r],[r,_,_,_],[_,_,r,_]].

%--------------------------------- P A T R I S S --------------------------------------------------
/*
apaga(X,[X|Y],Y).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

solucao(N,S) :- 
     crialista(N,L),
     criasup(N,DS),
     criainf(N,DI),
     resolve(S,L,L,DS,DI), tabela(N, S).

resolve([],[],_,_,_).
resolve([C|LC],[L|LL],CO,DS,DI):-
    apaga(C,CO,CO1),
    NS is L - C,
    NI is L + C,
    apaga(NS,DS,DS1),
    apaga(NI,DI,DI1),
    resolve(LC,LL,CO1,DS1,DI1).

crialista(N,[N|L]):-N > 0, N1 is N-1, crialista(N1,L).
crialista(0,[]).

intervalo(X,Y,Z) :- (X<Y), Z = [], !.
intervalo(X,Y,[X|Z]) :- X1 is X - 1, intervalo(X1,Y,Z), !.

criasup(X,Y) :- Z is (-X + 1), X1 is X - 1, intervalo(X1,Z,Y).
criainf(X,Y) :- Z is X * 2, intervalo(Z,2,Y).

criacao(0,_,[]).
criacao(X,Y,[Z|O]) :- X == Y,X1 is X-1, Z is "R", criacao(X1,Y,O).
criacao(X,Y,[Z|O]) :- X > 0, X1 is X-1, Z is "N", criacao(X1, Y, O).

linha(0, _) :- !.
linha(N, X) :- N1 is N - 1, linha(N1, X), (N =:= X -> write('r'); write('_')), write(',').

desenhar(0, _, []) :- !.
desenhar(N1, N2, [A|B]) :- write(' [ '), linha(N2, A), write(' ] '), 
                           N1Aux is N1 - 1, desenhar(N1Aux, N2, B).

tabela(N, S) :- desenhar(N, N, S).
*/

%------------------------------------ M E ------------------------------------------------

%solucao(N, S) :- crialista(N, I), criasup(N, J),
%    criainf(N,K), resolve(S, I, I, J, K), tabela(N, S).

% O que esse programa faz, ele vai tentando definir posições para as rainhas em um tabulerio NxN, 
% sem que elas consiga se capturar.

solucao(N,S) :- % Predicado principal para ser chamado na resposta. N é o número de rainhas, 
    		    % e S é a quantidade possivel de soluções.
     crialista(N,L),
     criasup(N,DS),
     criainf(N,DI),
     resolve(S,L,L,DS,DI), 
     tabela(N, S).

% Isso basicamente apaga a linha, coluna e diagonais que uma rainha foi posicionada.   
resolve([], [], _, _, _). % se não tem nenhuma linha para posicionar([]), teremos uma 
						  % lista vazia como solução([]) //isso é o fim da recursão

resolve([C|LC], [L|LL], CO, DS, DI) :- % dado uma linha L, uma lista de colunas (CO), 
    								   % diagonais superiores(DS) e diagonais inferiores (DI).
    apaga(C, CO, CO1), % para cada linha L se tenta apagar uma coluna C, e resta as outras colunas (C01).
    NS is L - C, % NS é o número da diagonal superior para essa linha e essa coluna, que será L-C.
    apaga(NS, DS, DS1), % a diagonal superior será apagada da lista de diagonais superiores (DS), e 
    					% teremos o restante dessas diagonais (DS1).
    NI is L + C, % Ni será o número da diagonal inferior para a linha L e coluna C, que será L+C.
    apaga(NI, DI, DI1), % a diagonal inferior será apagada da lista de diagonais inferiores (DI) e teremos 
    					% o restante dessas diagonais (DI1)
    resolve(LC, LL, CO1, DS1, DI1). %por fim temos a chamada recursiva para montar o 
									% restante da lista de colunas LC, com o restante da lista de 
									% linhas LL, com o que sobrou com a lista de colunas e com o 
									% que sobrou das listas de diagonais

apaga(X,[X|Y],Y). % Apaga o primiero elemento de uma lista qual ele é a cabeça, 
				  % e retorna somente o Y.
apaga(A,[B|C],[B|D]) :- apaga(A,C,D). % apaga todas as ocorrências do elemento A em uma lista, 
									  % em uma lista em que temos B como cabeça, e C como calda, 
									  % ou seja, A é um elemento dessa lista, e D vai ser o resultado 
									  % de apagar o elemento A da lista com calda C que dá a calda D.

crialista(N,[N|L]):-N > 0, N1 is N-1, crialista(N1,L). % defina a cabeça = N e calda = L
crialista(0,[]). % se o número for 0, ele vai apagando o primeiro elemento da lista até 
				 % que a lista fique vazia e ele impirmia.

criasup(C, L) :- A is C*(-1)+1, B is C-1, % define o limite da diagonal subindo, ele vai númerando as diagonais
    									  % subundo de acordo com aquele sua aula.
    findall(N, between(A,B,N), L). % E reune tudo em uma lista
criainf(C, L) :- B is C*2, % define o limite da diagonal descendo, ele vai númerando as diagonais
    									  % descendo de acordo com aquele sua aula.
    findall(N, between(2,B,N), L). % E reune tudo em uma lista

linha(0, _) :- !. % Define quando N for igual a zero, e ele para.
linha(N, X) :- N1 is N - 1, linha(N1, X), (N =:= X -> write('r'); write('_')), % ele pega os valores da lista 
    																		   % de X, quando encontra o 
    																		   % numero correspondete, ele 
    																		   % coloca o 'r', e continua 
    																		   % escrevendo.
    		   							  (N =:= 4 -> write(''); write(',')). 
										  % escreve a linha caso obedeça as regras.

desenhar(0, _, []) :- !. % define uma lista começando de 0
desenhar(N1, N2, [A|B]) :- write(' [ '), linha(N2, A), write(' ] '), % ele escreve o começo da lista até 
   																	 % encontrar o final dela em cada elemento, 
   																	 % ele verifica a posição de cada 
   																	 % elemento de X na lista e escreve-o.
    																 
    					   N1Aux is N1 - 1, desenhar(N1Aux, N2, B).
						   % escreve os parenteses no inicio e fim de cada repetição.

tabela(N, S) :- desenhar(N, N, S). % desenha a 'tabela' na solução.

% Falar: Então, eu tive dificuldade e encontrei um vídeo no Youtube que tinha uma solução de outro
% exercicio na internet que ele resolvia com Write, então eu pensei em tentar fazer isso e saiu isso
% que eu te mandei.

%------------------------------------ l U I Z I N H O -------------------------------------
/*
apaga(X,[X|Y],Y).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

solucao(N,S) :- 
     crialista(N,L),
     criasup(N,DS),
     criainf(N,DI),
     findall(S, resolve(S,L,L,DS,DI), S).

resolve([],[],_,_,_).
resolve([C|LC],[L|LL],CO,DS,DI):-
    apaga(C,CO,CO1),
    NS is L - C,
    NI is L + C,
    apaga(NS,DS,DS1),
    apaga(NI,DI,DI1),
    resolve(LC,LL,CO1,DS1,DI1).

crialista(N,[N|L]):-N > 0, N1 is N-1, crialista(N1,L).
crialista(0,[]).

criasup(C, L) :- A is C*(-1)+1, B is C-1,
    findall(N, between(A,B,N), L).
criainf(C, L) :- B is C*2,
    findall(N, between(2,B,N), L).
*/

%----------------------------- F U N C I O N A (OU NÃO) ---------------------------------

%:- use_rendering(chess).

% A solucao: X = [2, 4, 1, 3], deverá ser apresentada como: 
% 				 [[_,r,_,_],[_,_,_,r],[r,_,_,_],[_,_,r,_]].

/*
solucao(N, S) :- crialista(N, I), criasup(N, J),
    criainf(N,K),
    resolve(S, I, I, J, K), tabela(N, S).

resolve([], [], _, _, _).
resolve([C|LC], [L|LL], CO, DS, DI) :-
    apaga(C, CO, CO1),
    NS is L - C,
    apaga(NS, DS, DS1),
    NI is L + C,
    apaga(NI, DI, DI1),
    resolve(LC, LL, CO1, DS1, DI1).
    
apaga(A, [A|B], B).
apaga(X, [Y|Z], [Y|Z1]) :- apaga(X, Z, Z1).

crialista(C, L) :-
    findall(N, between(1 , C, N), L).

criasup(Count, List) :- De is Count * (-1) + 1, Ate is Count-1,
    findall(N, between(De, Ate, N), List).

criainf(Count, List) :- Ate is Count*2,
    findall(N, between(2, Ate, N), List).

linha(0, _) :- !.
linha(X, V) :- X1 is X - 1, linha(X1, V), (X =:= V -> write('r'); write('_')), write(',').
                  
desenhar(0, _, []) :- !.
desenhar(N1, N2, [A|B]) :- write(' [ '), linha(N2, A), write(' ] '), 
    					   N1Aux is N1 - 1, desenhar(N1Aux, N2, B).

tabela(N, S) :- desenhar(N, N, S).
*/