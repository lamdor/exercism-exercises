class EmptyBufferException() extends Exception {}

class FullBufferException() extends Exception {}

class CircularBuffer(var capacity: Int) {

  private var items = List[Int]()

  def write(value: Int) = 
    if (capacity > items.length) {
      items = items.appended(value)
    } else {
      throw new FullBufferException()
    }

  def read(): Int = items match {
    case head :: tail => 
      items = tail
      return head
    case _ =>
      throw new EmptyBufferException()
  }

  def overwrite(value: Int) =  {
    if (items.length >= capacity) {
      items = items.tail
    }

    write(value)
  }

  def clear() = items = List()
}
