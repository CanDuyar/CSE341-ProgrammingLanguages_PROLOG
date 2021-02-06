
%******CAN DUYAR - 171044075********%
%*********** PART 6 ****************%

% explanations of parameters
% Rn means number of row
% Cn means number of column
% Sol means solution


listLen(Len,List) :- length(List,Len).

rectangleShape(_,[]).
rectangleShape([],_).
rectangleShape([[X|Row1]|R],[[X|Col1]|C]) :-
   row_final(Row1,C,CR), 
   rectangleShape(R,[Col1|CR]).   

row_final([],[],[]).
row_final([X|Row],[[X|Col1]|C],[Col1|CR]) :- row_final(Row,C,CR).

merge([],[],[]).
merge([L1|Ls],[N1|Ns],[process(L1,N1)|Ts]) :- merge(Ls,Ns,Ts).

final([]).
final([process(Line,LR)|T]) :- 
   steps(LR,Line),
   final(T).

shape(NumberOfRows,NumberOfColumns,R,C) :-
   NumberOfRows > 0, NumberOfColumns > 0,
   length(R,NumberOfRows),
   Prediction =.. [listLen, NumberOfColumns],
   checklist(Prediction,R),
   length(C,NumberOfColumns),
   Prediction2 =.. [listLen, NumberOfRows],
   checklist(Prediction2,C),
   rectangleShape(R,C).


puzzle(Rn,Cn,Sol) :-
   length(Cn,NumberOfColumns),
   length(Rn,NumberOfRows),
   shape(NumberOfRows,NumberOfColumns,R,C),
   append(Rn,Cn,Ln),
   append(R,C,L),
   maplist(runPred,Ln,LR),
   merge(L,LR,LT),
   final(LT),
   Sol = R.
 

runPred([],[]) :- !.
runPred([Len1|Lens],[Run1-T|Runs]) :-mark(Len1,Run1,T),runPrediction2(Lens,Runs).

runPrediction2([],[]).

runPrediction2([Len1|Lens],[[' '|Run1]-T|Runs]) :- mark(Len1,Run1,T),runPrediction2(Lens,Runs).

mark(0,T,T) :- !.
mark(N,['x'|Xs],T) :- N > 0, N1 is N-1, mark(N1,Xs,T).

steps([],[]).
steps([Line-Rest|Runs],Line) :- steps(Runs,Rest).
steps(Runs,[' '|Rest]) :- steps(Runs,Rest).

print_Rn([]) :- nl.
print_Rn([N|Ns]) :- write(' '),write(N),write(' '), print_Rn(Ns).    % sayilarin arasina bastirilan bosluk

print_Cn(Cn) :-maxlength(Cn,M,0), print_Cn(Cn,Cn,1,M).

maxlength([],M,M).
maxlength([L|Ls],M,A) :- length(L,N), B is max(A,N), maxlength(Ls,M,B). 
 

print_puzzle([],Cn,[]) :- print_Cn(Cn).
print_puzzle([Rn1|Rn],Cn,[Row1|R]) :- print_row(Row1), print_Rn(Rn1),print_puzzle(Rn,Cn,R).

print_row([]) :- write('  ').
print_row([X|Xs]) :- change(X,Y), write(''), write(Y), print_row(Xs).   %X disinda kalan bosluklar.
   
change(' ','_|') :- !.
change(x,'X|').


print_Cn(_,[],M,M) :- !, nl.
print_Cn(Cn,[],K,M) :- K < M, !, nl,
K1 is K+1, print_Cn(Cn,Cn,K1,M).
print_Cn(Cn,[Col1|C],K,M) :- K =< M, 
printElement(K,Col1), print_Cn(Cn,C,K,M).
printElement(K,List) :- nth1(K,List,X), !, writef('%2r',[X]).
printElement(_,_) :- write('  ').

output_puzzle([],Cn,[], File) :- output_Cn(Cn, File).
output_puzzle([Rn1|Rn],Cn,[Row1|R], File) :- output_row(Row1, File), output_Rn(Rn1, File), output_puzzle(Rn,Cn,R, File).

output_row([], File) :- write(File, '  ').
output_row([X|Xs], File) :- change(X,Y), write(File, ''), write(File, Y), output_row(Xs, File).

output_Cn(Cn, File) :-maxlength(Cn,M,0), output_Cn(Cn,Cn,1,M, File).

output_Cn(_,[],M,M, File) :- !, nl(File).
output_Cn(Cn,[],K,M, File) :- K < M, !, nl(File ),
K1 is K+1, output_Cn(Cn,Cn,K1,M, File).
output_Cn(Cn,[Col1|C],K,M, File) :- K =< M, 
outputElement(K,Col1, File), output_Cn(Cn,C,K,M, File).

outputElement(K,List, File) :- nth1(K,List,X), !, swritef(Result, '%2r',[X]), write(File, Result).
outputElement(_,_, File) :- write(File, '  ').

output_Rn([], File) :- nl(File).
output_Rn([N|Ns], File) :- write(File, ' '),write(File, N),write(File, ' '), output_Rn(Ns, File). 

%In this part, I tested my code
%****************************TEST PART ************************************%



test_mode(TestNo) :- 
   example(TestNo,Rs,Cs),
   puzzle(Rs,Cs,Sol), nl,
   print_puzzle(Rs,Cs,Sol), 
   open('output.txt',write,File),
   output_puzzle(Rs,Cs,Sol,File),
   close(File).




%**************************PUZZLE EXAMPLES(from pdf)**********************%

example(
	'gtu1',
	[[3], [2,1], [3,2], [2,2], [6], [1,5], [6], [1], [2]],
	[[1,2], [3,1], [1,5], [7,1], [5], [3], [4], [3]]
	).

example(
	'gtu2',
	[[3,1], [2,4,1], [1,3,3], [2,4], [3,3,1,3], [3,2,2,1,3],
	 [2,2,2,2,2], [2,1,1,2,1,1], [1,2,1,4], [1,1,2,2], [2,2,8],
	 [2,2,2,4], [1,2,2,1,1,1], [3,3,5,1], [1,1,3,1,1,2],
	 [2,3,1,3,3], [1,3,2,8], [4,3,8], [1,4,2,5], [1,4,2,2],
	 [4,2,5], [5,3,5], [4,1,1], [4,2], [3,3]],
	[[2,3], [3,1,3], [3,2,1,2], [2,4,4], [3,4,2,4,5], [2,5,2,4,6],
	 [1,4,3,4,6,1], [4,3,3,6,2], [4,2,3,6,3], [1,2,4,2,1], [2,2,6],
	 [1,1,6], [2,1,4,2], [4,2,6], [1,1,1,1,4], [2,4,7], [3,5,6],
	 [3,2,4,2], [2,2,2], [6,3]]
	).

example(
	'gtu3',
	[[5], [2,3,2], [2,5,1], [2,8], [2,5,11], [1,1,2,1,6], [1,2,1,3],
	 [2,1,1], [2,6,2], [15,4], [10,8], [2,1,4,3,6], [17], [17],
	 [18], [1,14], [1,1,14], [5,9], [8], [7]],
	[[5], [3,2], [2,1,2], [1,1,1], [1,1,1], [1,3], [2,2], [1,3,3],
	 [1,3,3,1], [1,7,2], [1,9,1], [1,10], [1,10], [1,3,5], [1,8],
	 [2,1,6], [3,1,7], [4,1,7], [6,1,8], [6,10], [7,10], [1,4,11],
	 [1,2,11], [2,12], [3,13]]
	).
