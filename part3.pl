
%**********CAN DUYAR - 171044075***********%
%*************** PART 3 *******************%

%knowledge base
when(102, 10).
when(108, 12).
when(341, 14).
when(455, 16).
when(452, 17).

where(102, z23).
where(108, z11).
where(341, z06).
where(455, 207).
where(452, 207).

enroll(a,102).
enroll(a,108).
enroll(b,102).
enroll(c,108).
enroll(d,341).
enroll(e,455).

%rules

%3.1
schedule(S, P, T) :- enroll(S, Class), where(Class, P), when(Class,T).

%b3.2
usage(P, T) :- where(Class,P), when(Class,T).


%c3.3
%conflicting of times
timeconflict(Class1, Class2) :-
    when(Class1, T) ,
    when(Class2, T2),T==T2.

%conflicting of places
placeconflict(Class1, Class2) :-
    where(Class1, P) ,
    where(Class2, P2),P==P2.

conflict_help(X,Y):- timeconflict(X,Y);placeconflict(X,Y).

conflict(Cl1, Cl2) :-
    Cl1 \= Cl2 ,
    conflict_help(Cl1, Cl2) .


%3.4
meet(Student1, Student2) :-
    Student1 \= Student2 ,
    enroll(Student2, Class2) ,
    enroll(Student1, Class1) ,
    timeconflict(Class1, Class2),
    placeconflict(Class1, Class2).



