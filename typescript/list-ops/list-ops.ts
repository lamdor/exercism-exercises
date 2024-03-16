interface ListOps<Type> {
  forEach(fn: (a: Type) => void): void;
  append<Other>(other: ListOps<Other>): ListOps<Other | Type>;
  concat<Other>(other: ListOps<Other>): ListOps<Other | Type>;
  filter<Other extends Type>(fn: (a: Other) => boolean): ListOps<Type>;
  length(): number;
  map<Other extends Type>(fn: (a: Other) => Other): ListOps<Other>;
  foldl<Other extends Type, Mapped>(
    fn: (acc: Mapped, a: Other) => Mapped,
    init: Mapped,
  ): Mapped;
  foldr<Other extends Type, Mapped>(
    fn: (acc: Mapped, a: Other) => Mapped,
    init: Mapped,
  ): Mapped;
  reverse(): ListOps<Type>;
}

export class List {
  public static create<Type>(...values: Type[]): ListOps<Type> {
    // Do *not* construct any array literal ([]) in your solution.
    // Do *not* construct any arrays through new Array in your solution.
    // DO *not* use any of the Array.prototype methods in your solution.

    // You may use the destructuring and spreading (...) syntax from Iterable.

    if (values.length > 0) {
      let [first, ...rest] = values;
      return new Cons(first, List.create(...rest));
    } else {
      return Nil;
    }
  }
}

function isList(object: any): object is ListOps<any> {
  return "append" in object;
}

class Cons<Type> implements ListOps<Type> {
  head: Type;
  tail: ListOps<Type>;

  constructor(head: Type, tail: ListOps<Type>) {
    this.head = head;
    this.tail = tail;
  }

  forEach(fn: (a: Type) => void): void {
    fn(this.head);
    this.tail.forEach(fn);
  }

  append<Other>(other: ListOps<Other>): ListOps<Type | Other> {
    return new Cons(this.head, this.tail.append(other));
  }

  concat<Other>(other: ListOps<Other>): ListOps<Type | Other> {
    let accum: ListOps<Type | Other> = this.tail;
    other.forEach((a) => {
      if (isList(a)) {
        accum = accum.append(a);
      } else {
        accum = accum.append(List.create(a));
      }
    });
    return new Cons(this.head, accum);
  }

  filter<Other extends Type>(fn: (a: Other) => boolean): ListOps<Type> {
    if (fn(this.head as Other)) {
      return new Cons(this.head, this.tail.filter(fn));
    } else {
      return this.tail.filter(fn);
    }
  }

  length(): number {
    return 1 + this.tail.length();
  }

  map<Other extends Type>(fn: (a: Other) => Other): ListOps<Other> {
    return new Cons(fn(this.head as Other), this.tail.map(fn));
  }

  foldl<Other extends Type, Mapped>(
    fn: (acc: Mapped, a: Other) => Mapped,
    init: Mapped,
  ): Mapped {
    return this.tail.foldl(fn, fn(init, this.head as Other));
  }

  foldr<Other extends Type, Mapped>(
    fn: (acc: Mapped, a: Other) => Mapped,
    init: Mapped,
  ): Mapped {
    return fn(this.tail.foldr(fn, init), this.head as Other);
  }

  reverse(): ListOps<Type> {
    return this.foldr<Type, ListOps<Type>>(
      (acc, a) => acc.append(List.create(a)),
      Nil,
    );
  }
}

const Nil: ListOps<never> = {
  forEach(fn) {
    return;
  },
  append(other) {
    return other;
  },
  concat(other) {
    return other;
  },
  filter(fn) {
    return this;
  },
  length() {
    return 0;
  },
  map(fn) {
    return this;
  },
  foldl(fn, init) {
    return init;
  },
  foldr(fn, init) {
    return init;
  },
  reverse() {
    return this;
  },
};
