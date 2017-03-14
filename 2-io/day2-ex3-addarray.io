// Write a program to add up all of the numbers in a two-dimensional array.

inputArray := list(list(1,2,3), list(9, 8, 7))
inputVector := list(1,2,3)

sumVec := method(vec, sum := 0; vec foreach (val, sum = sum + val))
sumVec(inputVector) println

//sumArray := method(mat, sum := 0; mat foreach(l, sum = sum + sumVec(l)))
sumArray := method(mat, sumVec(mat flatten))

sumArray(inputArray) println


// functional??
// sumVec_map := method(vec, sum := 0; map(x, sum = sum+x))
// na, that doesnt make sense. map != fold.
// it's reduce!
sumArrayF := method(mat, mat flatten reduce(+))
sumArrayF(inputArray) println
