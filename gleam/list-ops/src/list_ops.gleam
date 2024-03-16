pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  case first {
    [a,..aa] -> [a, ..append(aa, second)]
    [ ] ->  second 
  }
}

pub fn concat(lists: List(List(a))) -> List(a) {
  case lists {
    [aa,..aaa] -> append(first: aa, second: concat(aaa)) 
    [ ] -> [ ]
  }
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  foldr(over: list, from: [], with: fn(aa, a) { 
    case function(a) {
      True -> [a, ..aa]
      False -> aa
    }
  })
}

pub fn length(list: List(a)) -> Int {
  foldl(over: list, from: 0, with: fn(n,_) { n + 1 })
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  foldr(over: list, from: [], with: fn(bs, a) { [function(a), ..bs] })
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [a, ..rest] -> foldl(over: rest, from: function(initial, a), with: function)
    [] -> initial
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [a, ..aa] -> function(foldr(over: aa, from: initial, with: function), a)
    [] -> initial
  }
}

pub fn reverse(list: List(a)) -> List(a) {
  foldl(over: list, from: [], with: fn(aa, a) { [a,..aa] })
}
