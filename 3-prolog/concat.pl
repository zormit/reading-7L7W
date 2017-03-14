concatenate([], List1, List1).
concatenate([Head|Tail], List, [Head|Conlist]) :- concatenate(Tail, List, Conlist).
