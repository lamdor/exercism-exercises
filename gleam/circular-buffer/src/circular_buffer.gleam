import gleam/queue
import gleam/result

pub opaque type CircularBuffer(t) {
  CircularBuffer(capacity: Int, queue: queue.Queue(t))
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer(capacity, queue.new())
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  result.map(over: queue.pop_front(from: buffer.queue), with: fn(a) {
    case a {
      #(i, q) -> #(i, CircularBuffer(..buffer, queue: q))
    }
  })
}

pub fn write(
  buffer: CircularBuffer(t),
  item: t,
) -> Result(CircularBuffer(t), Nil) {
  case buffer.capacity > queue.length(buffer.queue) {
    True -> {
      let q = queue.push_back(onto: buffer.queue, this: item)
      Ok(CircularBuffer(..buffer, queue: q))
    }
    False -> Error(Nil)
  }
}

pub fn overwrite(buffer: CircularBuffer(t), item: t) -> CircularBuffer(t) {
  case buffer.capacity > queue.length(buffer.queue) {
    True -> {
      let q = queue.push_back(onto: buffer.queue, this: item)
      CircularBuffer(..buffer, queue: q)
    }
    False -> {
      let queue = {
        result.unwrap(
          result.map(over: queue.pop_front(from: buffer.queue), with: fn(a) {
            case a {
              #(_i, q) -> q
            }
          }),
          or: queue.new(),
        )
      }
      CircularBuffer(..buffer, queue: queue.push_back(queue, item))
    }
  }
}

pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  CircularBuffer(..buffer, queue: queue.new())
}
