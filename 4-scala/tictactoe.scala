object Move extends Enumeration {
  type Move = Value
  val Empty = Value("_")
  val X, O = Value
  // http://stackoverflow.com/a/33593636/
  // def withNameOpt(s: String): Option[Value] = values.find(_.toString == s)
}

class Game {
  import Move._

  val size = 3
  val rowDelimiter = "\n"

  // represent the field by nested arrays of Moves
  // http://stackoverflow.com/a/15759115
  val rows = Array.fill[Move](size, size) { Empty }

  def this(board: String) {
    this()
    val inputRows = board.split(rowDelimiter)
    for (rowIdx <- 0 until inputRows.size) {
      val inputRow = inputRows(rowIdx)
      assert (inputRow.length == 3, "invalid input")
      for (colIdx <- 0 until size) {
        val fieldValue = inputRow(colIdx).toString
        rows(rowIdx)(colIdx) = fieldValue match {
          case "X" => X
          case "O" => O
          case "_" => Empty
        }
      }
    }
  }
  // END CONSTRUCTORS

  def fill(col: Int, row: Int, move: Move) {
    if(rows(row)(col) == Empty) {
      rows(row)(col) = move
    } else {
      println("Invalid move.")
    }
  }

  def xFill(col: Int, row: Int) {
    fill(row, col, X)
  }

  def oFill(col: Int, row: Int) {
    fill(col, row, O)
  }

  override def toString: String = {
    var repr = ""
    rows.foreach { row =>
      row.foreach { field => repr += field.toString }
      repr += rowDelimiter
    }
    // remove last delimiter
    return repr.substring(0, repr.size-1)
  }
}

// Tests. Put here, because it's easier for a proof of concept, modules on the console seems to be annoying

var game: Game = new Game
game.xFill(1, 1)
game.oFill(0, 2)
// https://www.safaribooksonline.com/library/view/scala-cookbook/9781449340292/ch01s03.html
val expectedString = """___
                       |_X_
                       |O__""".stripMargin
// http://alvinalexander.com/scala/scala-compare-strings-with-equal-operator-method-not-equals
assert (game.toString == expectedString, "the game is not in expected state.")

var newGame ="""XOX
               |_XO
               |__O""".stripMargin
game = new Game(newGame)
assert (game.toString == newGame, "the game is not in expected state.")
