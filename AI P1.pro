test:-go([ 1 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,0 , 1 , 1 , 1 , 1 , 0 , 1 , 1 , 1 , 0 ,0 , 1 , 0 , 0 , 1 , 1 , 1 , 0 , 1 , 0 ,0 , 1 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , 0 ,0 , 1 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , 1 ,0 , 1 , 0 , 1 , 1 , 0 , 0 , 0 , 0 , 0 ,0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ] , 0 , 69 ).

% ------------------ UP  ------------------
move(M,I,J):-
  	up(M,I,J).

up(M,I,J):-
	I > 9 ,  
  	J is I-10 ,
	nth( R , M , J ) ,
	R =:= 1.


%  ------------- DOWN -------------
move(M,I,J):-
  	down(M,I,J).

down(M,I,J):-
   	I < 89 , 
	J is I+10 ,
	nth( R , M , J ) ,
	R =:= 1.


% ------------------ LEFT  ------------------
move(M,I,J):-
  	left(M,I,J).

left(M,I,J):-
	I > 0 ,
	J is I-1 ,
	nth( R , M , J ) ,
	R =:= 1.

% ------------------  RIGHT  ------------------
move(M,I,J):-
  	right(M,I,J).

right(M,I,J):-
	I < 99 ,
	J is I +1 ,
	nth( R , M , J ) ,
	R =:= 1.
	

:-use_module(library(lists)).

go(Maze,Start,Goal):-
		path([[Start,null]],[],Goal).


path([],_,_):-
		write('No solution'),nl,!.
path([[Goal,Parent] | _], Closed, Goal):-
		write('A solution is found'), nl ,
		printsolution([_,Parent],Closed),!.
path(Open, Closed, Goal):-
		removeFromOpen(Open, [State, Parent], RestOfOpen),
		getchildren(State, Open, Closed, Children),
		addListToOpen(Children , RestOfOpen, NewOpen),
		path(NewOpen, [[State, Parent] | Closed], Goal).


getchildren(State, Open ,Closed , Children):-
		bagof(X, moves( Maze,State, Open, Closed, X), Children), ! .
getchildren(_,_,_, []).


addListToOpen([],Children,Children).
addListToOpen( [H|Open] , L  ,  [H|NewOpen] ):-
		addListToOpen(L, Open, NewOpen).


removeFromOpen([State|RestOpen], State, RestOpen).


moves(Maze, State, Open, Closed,[Next,State]):-
		move(Maze,State,Next),
		\+ member([Next,_],Open),
		\+ member([Next,_],Closed).

printsolution([State, null],_):-
		write(State),nl.
printsolution([State, Parent], Closed):-
		member([Parent, GrandParent], Closed),
		printsolution([Parent, GrandParent], Closed),
		write(State), nl.