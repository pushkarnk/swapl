/* Math operators of APL */
import Foundation

prefix operator +
prefix operator -
prefix operator ×
prefix operator ÷
prefix operator ⌈
prefix operator ⌊


infix operator +: AdditionPrecedence
infix operator -: AdditionPrecedence
infix operator ×: MultiplicationPrecedence
infix operator ÷: MultiplicationPrecedence
infix operator ⌈: AdditionPrecedence
infix operator ⌊: AdditionPrecedence



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

//Plus
public func +(as: [Double], ws: [Double]) -> [Double] {
    return operateBinary(`as`, ws, +)
}

//Minus
public func -(as: [Double], ws: [Double]) -> [Double] {
    return operateBinary(`as`, ws, -)
}

//Times
public func ×(as: [Double], ws: [Double]) -> [Double] {
    return operateBinary(`as`, ws, *)
}

//Divide
public func ÷(as: [Double], ws: [Double]) -> [Double] {
    return operateBinary(`as`, ws, /)
}

//Maximum
public func ⌈(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w) { $0 > $1 ? $0 : $1 }
}

//Minimum
public func ⌊(a: [Double], w: [Double]) -> [Double] {
    return operateBinary(a, w) { $0 < $1 ? $0 : $1 }
}

private func operateBinary(_ as: [Double], _ ws: [Double], _ op: (Double, Double) -> Double) -> [Double] {
    if `as`.count == 1 {
        return ws.map { op(`as`[0], $0) }
    }

    if ws.count == 1 {
        return `as`.map { op($0, ws[0]) }
    }

    guard `as`.count == ws.count else {
        //TODO: design an error class
        print("Length Error");
        return []
    }

    //TODO: do functionally?
    var result = [Double]()
    for i in 0..<`as`.count {
        result.append(op(`as`[i], ws[i]))
    }
    return result
}
