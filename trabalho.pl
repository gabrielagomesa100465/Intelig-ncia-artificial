% Extensão do predicado utente: Numero_do_utente,Nome,Cidade,Sexo,Antecedentes_familiares -> {V,F,D}                           Numero_do_utente começa 1,2,3,...; Antecedentes_familiares é "sim" ou "nao" (se tinha gente na família que era gooooooooorda)
% Extensão do predicado registo: Registo,Numero_do_utente,Dia,Mes,Ano,Idade,Altura(em cm),Peso,Tipo_de_dieta -> {V,F,D}       no Tipo_de_dieta, é dizer se é "boa" ou "ma"; n Registo, vamos criar um numero a toa, cada registo vai ter um número associado. assim, podem haver varios registos pra mesma pessoa. podemos definir tipo que o registo tenha um número de 4 algarismos
% Extensão do predicado imc: Registo,Numero_do_utente,Imc_valor,Classificacao,Lim_inf,Lim_sup -> {V,F,D}

:-op(900,xfy,'::').
:-dynamic('-'/1).
:-dynamic('+'/1).
:-dynamic(utente/5).
:-dynamic(registo/9).
:-dynamic(imc/6).

nao(Questao):- Questao,
                 !,
                 fail.
nao(Questao).

si(Questao,verdadeiro) :- Questao.
si(Questao,falso) :- -Questao.
si(Questao,desconhecido) :- nao(Questao),nao(-Questao).

% Pressupostos do Mundo Fechado
-utente(Nu,N,C,S,A):-nao(utente(Nu,N,C,S,A)),
                nao(excecao(utente(Nu,N,C,S,A))).

-registo(R,Nu,D,M,A,I,Al,P,Td):-nao(registo(R,Nu,D,M,A,I,Al,P,Td)),
                nao(excecao(registo(R,Nu,D,M,A,I,Al,P,Td))).

% Cálculo do imc 
calcular_imc(Nu,P,Al,Imc_valor):- Imc_valor is P/(Al*Al).
avaliar_imc(Nu,Imc_valor,Cl):-
    Imc_valor < 10,
    Cl = 'Magreza'; % nao temos a certeza
    Imc_valor >= 18.5 , Imc_valor < 24.9,
    Cl = 'Normal';
    Imc_valor >= 25, Imc_valor < 29.9,
    Cl = 'Sobrepeso';
    Imc_valor >= 30, Imc_valor < 34.9,
    Cl = 'Obesidade moderada';
    Imc_valor >= 35, Imc_valor < 39.9,
    Cl = 'Obesidade severa';
    Imc_valor >= 40, 
    Cl = 'Obesidade mórbida'.

% conhecimento perfeito
utente(1,maria,braga,f,nao).
registo(r1,1,24,10,2023,30,163,55,boa).
imc(r1,1,20.7,normal,18.5,24.9).

utente(2,nuno,evora,m,sim).
registo(r1,2,24,10,2023,56,179,86,boa).
imc(r1,2,26.8,sobrepeso,24.9,30).

% conhecimento incerto
excecao(utente(Nu,N,C,S,A)):-utente(nao_sabe,nao_sabe,nao_sabe,nao_sabe,nao_sabe)
utente(3,francisca,povoa,f,nao_sabe).
registo(r1,3,20,09,2021,13,157,44,mal).    % imc = 17.9
registo(r2,3,22,09,2022,14,161,46,mal).   % imc = 17.7

excecao(registo(R,Nu,D,M,A,I,Al,P,Td)):-registo(R,Nu,D,M,A,I,nao_sabe,nao_sabe,Td)
utente(4,joana,porto,f,nao).
registo(r1,4,23,07,2020,34,nao_sabe,nao_sabe,boa).
