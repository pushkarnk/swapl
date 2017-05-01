/* Math operators of APL */
import Foundation

prefix operator ➕

public prefix func ➕(w: [Double]) -> [Double] {
    return w
}


infix operator ➕: AdditionPrecedence

public func ➕(as: [Double], ws: [Double] ) -> [Double] {
    if `as`.count == 1 {
        return ws.map { $0 + `as`.first!}
    }

    if ws.count == 1 {
        return `as`.map { $0 + ws.first!}
    }

    guard `as`.count == ws.count else {
        //TODO: design an error class
        print("Length Error");
        return []
    }

    //TODO: functionally?
    var sum: [Double] = []
    for i in 0..<`as`.count {
        sum.append(`as`[i] + ws[i])
    }
    return sum
}
