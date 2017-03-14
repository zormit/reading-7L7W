/* Add a slot called myAverage to a list that computes the average of
 * all the numbers in a list.
 */
List myAverage := method(avg := 0;
                         self foreach(val, avg = avg + val);
                         avg = avg / (self size))

// What happens if there are no numbers in a list?
// Io> List clone myAverage
// ==> -nan

// TODO (Bonus: Raise an Io exception if any item in the list is not a number.)
