
%******CAN DUYAR - 171044075********%
%************PART 5*****************%


div(L,G,T) :- G = [_|_], T = [_|_], append(G,T,L).


element2(Left,Right,Left*Right).
element2(Left,Right,Left/Right) :- Right =\= 0.  
element2(Left,Right,Left+Right).
element2(Left,Right,Left-Right).

final([L]) :- helper(L,Left,Right),print_to_file(Left, Right),fail.

final(_).


helper(Lst,L,R) :-
   div(Lst,Lparam,Rparam),
   element(Lparam,L),
   element(Rparam,R),
   L =:= R.

element([X],X).                    
element(L,T) :- div(L,Lparam,Rparam),
                element(Lparam,Left),
                element(Rparam,Right),
                element2(Left,Right,T).


turn(File, Left, Right) :-
    write(File, Left  ),
    write(File,  " = "  ),
    write(File, Right  ),
    write(File,"\n" ),
    fail.


print_to_file(Left, Right) :-
    open('output.txt', append, File),
    \+ turn(File, Left, Right),
    close(File).


readtxt(File,[]) :-
    at_end_of_stream(File).

readtxt(File,[X|L]) :-
    \+ at_end_of_stream(File),
    read(File,X),
    readtxt(File,L).


program :-
    open('input.txt', read, S),
    open('output.txt',write, File), close(File), % to clean output.txt 
    readtxt(S,Li),
    close(S),
    final(Li).
