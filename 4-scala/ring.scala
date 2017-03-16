object TrueRing {
 def rule = println("To rule them all")
}
TrueRing.rule
class TrueRing(val ringId:Int) {
  def printId = println(ringId)
}
val aRing = new TrueRing(4)
aRing.printId
// aRing.rule // results in a compile error.
