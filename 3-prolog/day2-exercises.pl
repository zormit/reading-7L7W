rever([], []).
rever([Head|Tail], Reverse) :-
    rever(Tail, RevTail),
    append(RevTail, [Head], Reverse).

min([Head|[]], Head).
min([Head|Tail], Head) :- min(Tail, Min), Head < Min.
min([Head|Tail], Min) :- min(Tail, Min), Head >= Min.

drop(Element, [Head|Tail], Tail) :- Element = Head.
drop(Element, [Head|Tail], [Head|DTail]) :- \+ Element = Head, drop(Element, Tail, DTail).
dtest(Dropped) :- drop(2, [1,2,3,2], Dropped).

srt([], []).
srt([Head|[]], [Head|[]]).
srt([Head1|[Head2|Tail]], [Head1|[Head2|TailSorted]]) :-
    Head1 < Head2,
    srt(Tail, TailSorted).
srt([Head1|[Head2|Tail]], [Head2|[Head1|TailSorted]]) :-
    Head1 >= Head2,
    srt(Tail, TailSorted).

test(Sorted) :- srt([4,2,1], Sorted).
%% test(Sorted) :- srt([3,1,4,1,6,8,2,5,4], Sorted).

minsort([], []).
minsort(List, [Min|ReducedSorted]) :-
    min(List, Min),
    drop(Min, List, Reduced),
    minsort(Reduced, ReducedSorted).
mtest(Sorted) :- minsort([4,2,1], Sorted).
mtest2(Sorted) :- minsort([3,1,4,1,6,8,2,5,4], Sorted).
