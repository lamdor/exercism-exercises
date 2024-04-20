import Foundation

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

class Squares {
    let n: Int

    init(_ n: Int) {
        self.n = n
    }

    var squareOfSum: Int {
        return (1...n).reduce(0) { $0 + $1 } ^^ 2
    }

    var sumOfSquares: Int {
        return (1...n).reduce(0) { $0 + ($1 ^^ 2) }
    }

    var differenceOfSquares: Int {
        return abs(squareOfSum - sumOfSquares)
    }
}
