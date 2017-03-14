/* Write a prototype for a two-dimensional list.
 * The dim(x, y) method should allocate a list of y lists
 * that are x elements long. set(x, y, value) should set a value,
 * and get(x, y) should return that value.
 */

Matrix := Object clone
Matrix dim := method(x, y,
                     self x := x
                     self y := y
                     data := List clone preallocateToSize(y)
                     for (row, 0, y-1,
                          rowData := List clone preallocateToSize(x)
                          for(col, 0, x-1,
                              rowData append(nil))
                          data append(rowData))
                     self _data := data)

Matrix set := method(x, y, value, self _data at(y) atPut(x, value))
Matrix get := method(x, y, value, self _data at(y) at(x))


Matrix transpose := method(new_m := Matrix clone
                           write("X/Y:")
                           write(self x)
                           writeln(self y)
                           new_m dim(self y, self x)
                           self _data foreach(row_idx, row,
                               row foreach(col_idx, val,
                                       writeln(row_idx)
                                       writeln(col_idx)
                                       // transpose: switch row/col idx
                                       new_m set(row_idx, col_idx, val)))
                           new_m)

Matrix saveFile := method(filename,
        file := File clone openForUpdating(filename)
        self _data foreach(row,
            row foreach(idx, val,
                file write(val asString)
                if (idx + 1 < row size) then(file write(",")) // suppress last comma
            )
            file write("\n")
        )
)

Matrix loadFile := method(filename,
        file := File clone openForReading(filename)
        lines := file readLines
        self y := lines size
        self x := lines at(0) split(",") size
        data := List clone preallocateToSize(y)
        lines foreach(line,
            rowData := List clone preallocateToSize(x)
            line split(",") foreach(val,
                number := val asNumber
                rowData append(if(number isNan, nil, number))
            )
            data append(rowData)
        )
        self _data := data
)

m := Matrix clone
m dim(3, 2)
m set(1, 1, 10)
m set(0, 1, 12)
m saveFile("m.csv")

n := Matrix clone
n loadFile("m.csv")
n set(2,1,5)
n saveFile("n.csv")
