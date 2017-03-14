// How would you change / to return 0 if the denominator is zero?
Number olddiv := Number getSlot("/")
Number / := method(n, if(n==0, 0, self olddiv(n)))
