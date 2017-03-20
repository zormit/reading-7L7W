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
      assert (inputRow.length == size, "invalid input")
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

  def fill(idx: Int, move: Move) {
    fill((idx-1) % 3, (idx-1) / 3, move)
  }

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

  // Scala question: when do I need "=" in a method def?
  def result(): Move = {
    /* the game is over:
     * A) when one of the players filled
     *    their mark in one row, column or diagonal
     * B) when the board is completely filled.
     *
     * brute force solution is ok for the size of 3x3,
     * although it is very inelegant to look at each field up to three times.
     */

    // there are #size rows and columns and 2 diagonals.
    val lines = new Array[Array[Move]](2*size + 2)
                // one problem: this contains nulls.
                // so looping over it might result in null pointer exception.
    var lineIdx: Int = 0

    // collect rows
    rows.foreach { row =>
      lines(lineIdx) = row
      lineIdx += 1
    }

    // collect columns
    for (colIdx <- 0 until size) {
      val col = new Array[Move](size)
      for (rowIdx <- 0 until size) {
        col(rowIdx) = rows(rowIdx)(colIdx)
      }
      lines(lineIdx) = col
      lineIdx += 1
    }

    val diagDown = new Array[Move](size) // down: "\", row = col
    val diagUp   = new Array[Move](size) // up:   "/", row = size-1-col
    for (idx <- 0 until size) {
      diagDown(idx) = rows(idx)(idx)
      diagUp(idx)   = rows(idx)(size-1-idx)
    }
    lines(lineIdx)   = diagDown
    lines(lineIdx+1) = diagUp

    // internal sanity check
    assert(!lines.contains(null), "not all lines were filled")

    lines.foreach { line =>
      val elements = line.distinct
      if(elements.length == 1 && elements(0) != Empty) {
        // we have a winner
        return elements(0)
      }
    }

    // we don't have a winner. is the game finished?
    val ongoing = rows.flatten.contains(Empty)
    if (!ongoing) {
      return Empty // Draw
    }

    null // no decision yet. this null is ugly.
  }

  override def toString: String = {
    var repr = ""
    rows.foreach { row =>
      row.foreach { field => repr += field.toString }
      repr += rowDelimiter
    }
    // remove last delimiter
    repr.substring(0, repr.size-1)
  }
}

class InteractiveGame {
  import Move._
  val game = new Game
  var currentPlayer = Move.X
  var stopGame = false
  println("Game starting...")
  println("(enter 0 to exit game)\n")

  while(game.result == null && !stopGame) {
    println("Next move (1-9) by player " + currentPlayer)

    var nextMove = Console.readInt()
    if (nextMove == 0) {
      println("exiting...")
      stopGame = true
    } else if (0 < nextMove && nextMove < 10){
      game.fill(nextMove, currentPlayer)
      println(game)
      currentPlayer = currentPlayer match {
          case X => O
          case O => X
      }
    } else {
      println("invalid input. try again.")
    }
  }

  val result = game.result
  result match {
    case Empty => println("The game is draw.")
    case X => println("X won.")
    case O => println("O won.")
  }
}

// Tests. Put here, because it's easier for a proof of concept, modules on the console seems to be annoying
class Tests {
  var game: Game = new Game
  game.xFill(1, 1)
  game.fill(2, 2, Move.X)
  game.fill(7, Move.O)
  // https://www.safaribooksonline.com/library/view/scala-cookbook/9781449340292/ch01s03.html
  val expectedString = """___
                         |_X_
                         |O_X""".stripMargin
  // http://alvinalexander.com/scala/scala-compare-strings-with-equal-operator-method-not-equals
  assert (game.toString == expectedString, "the game is not in expected state.")

  var newGame = """XOX
                  |_XO
                  |__O""".stripMargin
  game = new Game(newGame)
  assert (game.toString == newGame, "the game is not in expected state.")
  assert (game.result == null, "the game should be not decided yet.")

  newGame = """XXX
              |_XO
              |__O""".stripMargin
  game = new Game(newGame)
  assert (game.result == Move.X, "the game is won by X.")

  newGame = """XXO
              |_OX
              |O_O""".stripMargin
  game = new Game(newGame)
  assert (game.result == Move.O, "the game is won by O.")

  newGame = """XOO
              |OXX
              |OXO""".stripMargin
  game = new Game(newGame)
  assert (game.result == Move.Empty, "the game is draw.")
}
new Tests
new InteractiveGame
