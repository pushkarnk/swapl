/* Math operators of APL */
import Foundation

prefix operator +
prefix operator -
prefix operator ×
prefix operator ÷
prefix operator ⌈
prefix operator ⌊
prefix operator |
prefix operator ⍟
prefix operator !
prefix operator ✴
prefix operator ⸮

///TODO: Do all operators follow AdditionPrecedence?
infix operator +: AdditionPrecedence
infix operator -: AdditionPrecedence
infix operator ×: MultiplicationPrecedence
infix operator ÷: MultiplicationPrecedence
infix operator ⌈: AdditionPrecedence
infix operator ⌊: AdditionPrecedence
infix operator |: AdditionPrecedence
infix operator ⍟: AdditionPrecedence
infix operator !: AdditionPrecedence
infix operator ✴: AdditionPrecedence
infix operator ⸮ : AdditionPrecedence

///Monadic functions

//"Pseudo" Conjugate
public prefix func +(w: [Double]) -> [Double] {
    return w
}

//Negate
public prefix func -(w: [Double]) -> [Double] {
    return w.map { -$0 }
}

//Direction
public prefix func ×(w: [Double]) -> [Double] {
    return w.map { $0 < 0 ? -1 : ($0 > 0 ? 1 : 0) }
}

public prefix func ×(w: Double) -> Double {
    return w < 0 ? -1 : (w > 0 ? 1 : 0)
}

//Reciprocal
public prefix func ÷(w: [Double]) -> [Double] {
    return w.map { 1.0/$0 }
}

//Ceil
public prefix func ⌈(w: [Double]) -> [Double] {
    return w.map { ceil($0) }
}

//Floor
public prefix func ⌊(w: [Double]) -> [Double] {
    return w.map { floor($0) }
}

//Magnitude
public prefix func |(w: [Double]) -> [Double] {
    return w.map { $0.magnitude }
}

public prefix func |(w: Double) -> Double {
    return w.magnitude
}

//Natural logarithm
public prefix func ⍟(_ w: Double) -> Double {
    return log(w)
}

public prefix func ⍟(_ w: [Double]) ->[Double] {
    return w.map { log($0) }
}

//Factorial for whole numbers
//Gamma function for fractions, strangle !y = gamma(y+1)
public prefix func !(_ w: Double) -> Double {
    return factorialOrGamma(w)
}

public prefix func !(_ w: [Double]) -> [Double] {
    return w.map { factorialOrGamma($0) }
}

//Exponential
public prefix func ✴(_ w: [Double]) -> [Double] {
    return w.map { pow(M_E, $0) }
}

//Roll
public prefix func ⸮(_ w: [Int]) -> [Int] {
    w.forEach {
        guard $0 > 0 else { fatalError("Roll right argument must consist of non-negative integer(s)") }
    }
    return w.map { Int(arc4random_uniform(UInt32($0))) }
}

///Dyadic functions

//Plus
public func +(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w, +)
}

//Minus
public func -(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w, -)
}

//Times
public func ×(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w, *)
}

//Divide
public func ÷(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w, /)
}

//Maximum
public func ⌈(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w) { $0 > $1 ? $0 : $1 }
}

//Minimum
public func ⌊(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w) { $0 < $1 ? $0 : $1 }
}

//Residue
public func |(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w) { residue($0, $1) }
}

private func residue(_ x: Double, _ y: Double) -> Double {
    let r = |y.truncatingRemainder(dividingBy: |x)
    return r == 0 || x >= 0 && y >= 0 ? r : (×x) * (|x - r)
}

//Logarithm
public func ⍟(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w) { log($1) / log($0) }
}

//Binomial
public func !(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w) { isNegativeWhole($1 - $0) ? 0 : (!$1) / (!($1 - $0) * !$0) }
}

//Power
public func ✴(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w) { pow($0, $1) }
}

//Deal
public func ⸮(a: [Int], w: [Int]) -> [Int] {
    guard a.count == 1 && w.count == 1 else { fatalError("Length Error") }
    guard a.first! > 0 && w.first! > 0 else { fatalError("Deal right argument must be non-negative") }
    guard a.first! <= w.first! else { fatalError("Deal right argument must be greater than or equal to the left argument") }
    return Array(1...a.first!).flatMap { _ in ⸮w }
}

private func operateBinary(_ a: [Double], _ w: [Double], _ op: (Double, Double) -> Double) -> [Double] {
    if a.count == 1 {
        return w.map { op(a[0], $0) }
    }

    if w.count == 1 {
        return a.map { op($0, w[0]) }
    }

    guard a.count == w.count else {
        //TODO: design an error class
        print("Length Error");
        return []
    }

    //TODO: do functionally?
    var result = [Double]()
    for i in 0..<a.count {
        result.append(op(a[i], w[i]))
    }
    return result
}

private func factorialOrGamma(_ w: Double) -> Double {
    if isWhole(w) {
        //TODO: throw an error for negative integers
        return Double(factorial(Int(w)))
    }
    else {
        return gamma(w)
    }
}

private func factorial(_ x: Int) -> Int {
    guard x > 1 else { return 1 }
    return x * factorial(x-1)
}

private func gamma(_ x: Double) -> Double {
    return tgamma(x+1)
}

private func isWhole(_ x: Double) -> Bool {
    return x.truncatingRemainder(dividingBy: 1) == 0
}

private func isNegativeWhole(_ x: Double) -> Bool {
    return x < 0 && isWhole(x)
}
