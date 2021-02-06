
%******CAN DUYAR - 171044075********%
%************PART 4*****************%

% rules
%4.1
% true when E is an element of S 
element(E, S) :- memberchk(E, S).


%4.2 
% returns true if S3 is the union of S1 and S2
union(S1,S2,S3) :- unionGTU(S1,S2,Union), equivalent(Union,S3).
unionGTU([], S2, S2).
unionGTU([U|S1], S2, S3) :- element(U, S2), !, unionGTU(S1, S2, S3). 
unionGTU([U|S1], S2, [U|S3]) :- unionGTU(S1, S2, S3).



%4.4
% returns true if S1 is equal to S2	
equivalent(S1, S2) :- permutation(S1, S2).


%4.3
% returns true if S3 is intersection of S1 and S2
intersect(S1,S2,S3) :- intersectHelp(S1,S2,G), equivalent(G,S3).
intersectHelp([], _, []).
intersectHelp([E|S1], S2, [E|S3]):- element(E, S2), !, intersectHelp(S1, S2, S3).
intersectHelp([_|S1], S2, S3):- intersectHelp(S1, S2, S3).










