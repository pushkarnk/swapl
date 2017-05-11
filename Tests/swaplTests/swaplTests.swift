import XCTest
@testable import swapl

class swaplTests: XCTestCase {

    func testConjugate() {
        XCTAssert(+[1, 2, 3] == [1, 2, 3])
        XCTAssert(+[1] == [1])
        XCTAssert(+[1.2] == [1.2])
        XCTAssert(+[1.2,3.2,0,1.2] == [1.2,3.2,0,1.2])
    }

    func testPlus() {
        XCTAssert([1] + [2] == [3])
        XCTAssert([1] + [1,2,3] == [2, 3, 4])
        XCTAssert([1,2,3,4] + [9] == [10, 11, 12, 13])
        XCTAssert([1,2] + [4,5] == [5,7])
    }

    func testNegate() {
        XCTAssert(-[1.2, -1, 0] == [-1.2, 1, 0])
        XCTAssert(-[10] == [-10])
        let a: [Double] = [1,2,3,4,5,6]
        XCTAssert(-(-a) == a)
    }

    func testMinus() {
        let a1: [Double] = [1], w1 = [Double]([1, 2, 3, 4])
        XCTAssert(a1-w1 == [0, -1, -2, -3])

        let a2: [Double] = [1, 2, 3, 4], w2 = [Double]([1])
        XCTAssert(a2-w2 == [0, 1, 2, 3])

        let a3: [Double] = [10, 9, 8], w3 = [Double]([3, 2, 5])
        XCTAssert(a3-w3 == [7,7,3])
    }

    func testDirection() {
        let a1 = [Double]([-1, 2, 9, 124, -91, 0, -199])
        XCTAssert(×a1 == [-1, 1, 1, 1, -1, 0, -1])
    }

    func testTimes() {
        let a1 = [Double]([2]), w1 = [Double]([2])
        XCTAssert(a1×w1 == [4])
        let a2 = [Double]([2, 4, 8]), w2 = [Double]([2])
        XCTAssertEqual(a2×w2, [4, 8, 16])
        let a3 = [Double]([2]), w3 = [Double]([2,4,8])
        XCTAssertEqual(a3×w3, [4, 8, 16])
        let a4 = [Double]([2, 4, 8]), w4 = [Double]([2, 4, 8])
        XCTAssertEqual(a4×w4, [4, 16, 64])
    }

    func testReciprocal() {
        let a1 = [Double]([1, 2, 4, 5])
        XCTAssert(÷a1 == [1, 0.5, 0.25, 0.2])
    }

    func testDivide() {
        let a1 = [Double]([2]), w1 = [Double]([2])
        XCTAssert(a1÷w1 == [1])
        let a2 = [Double]([2, 4, 8]), w2 = [Double]([2])
        XCTAssertEqual(a2÷w2, [1, 2, 4])
        let a3 = [Double]([2]), w3 = [Double]([2,4,8])
        XCTAssertEqual(a3÷w3, [1, 0.5, 0.25])
        let a4 = [Double]([2, 4, 8]), w4 = [Double]([1, 2, 5])
        XCTAssertEqual(a4÷w4, [2, 2, 1.6])
    }

    func testCeil() {
        XCTAssert(⌈[1.9,-9.9,8.0,1,0,0.9,-0.8] == [2,-9,8,1,0,1,0])
    }

    func testFloor() {
        XCTAssert(⌊[1.9,-9.9,8.0,1,0,0.9,-0.8] == [1,-10,8,1,0,0,-1])
    }

    func testMaximum() {
        XCTAssertEqual([9.0] ⌈ [7.0, 9.0, 6.0 ,5.0, 4.9], [9.0, 9.0, 9.0, 9.0, 9.0])
        XCTAssertEqual([7.0, 9.0, 6.0 ,5.0, 4.9] ⌈ [9.0], [9.0, 9.0, 9.0, 9.0, 9.0])
        XCTAssertEqual([8.0, 9.0, 7.0] ⌈ [9.0, 5.0, 8.0] , [9.0, 9.0, 8.0])
    }

    func testMinimum() {
        XCTAssertEqual([9.0] ⌊ [7.0, 9.0, 6.0 ,5.0, 4.9], [7.0, 9.0, 6.0, 5.0, 4.9])
        XCTAssertEqual([7.0, 9.0, 6.0 ,5.0, 4.9] ⌊ [9.0], [7.0, 9.0, 6.0, 5.0, 4.9])
        XCTAssertEqual([8.0, 9.0, 7.0] ⌊ [9.0, 5.0, 8.0] , [8.0, 5.0, 7.0])
    }

    func testResidue() {
        XCTAssertEqual([2]|[3, 4, 0, -2, -3], [1, 0, 0, 0, 1])
        XCTAssertEqual([4, -3, 7, 9, -5]|[14], [2, -1, 0, 5, -1])
        XCTAssertEqual([-2, -2]|[9, -8], [-1, 0])
    }

    func testLogarithm() {
        XCTAssertTrue(almostEqual(⍟[2.718, 5.34], [0.9998963157, 1.675225653]))
        XCTAssertTrue(almostEqual([10] ⍟ [1, 10, 100, 1000], [0, 1, 2, 3]))
        XCTAssertTrue(almostEqual([10, 20, 30] ⍟ [100, 200, 300], [2, 1.768621787, 1.676992493]))
        let r = [6.64385619, 4.191806549, 3.321928095, 2.861353116, 2.570194418, 2.366589325, 2.21461873]
        XCTAssertTrue(almostEqual([2, 3, 4, 5, 6, 7, 8] ⍟ [100], r))
    }

    func almostEqual(_ x1: [Double], _ x2: [Double]) -> Bool {
        guard x1.count == x2.count else { return false }
        for i in 0..<x1.count {
            guard abs(x1[i] - x2[i]) <= 0.000000001 else { return false }
        }
        return true
    }

    static var allTests : [(String, (swaplTests) -> () throws -> Void)] {
        return [
            ("testConjugate", testConjugate),
            ("testPlus", testPlus),
            ("testNegate", testNegate),
            ("testMinus", testMinus),
            ("testDirection", testDirection),
            ("testTimes", testTimes),
            ("testReciprocal", testReciprocal),
            ("testDivide", testDivide),
            ("testCeil", testCeil),
            ("testFloor", testFloor),
            ("testMaximum", testMaximum),
            ("testMinimum", testMinimum),
            ("testResidue", testResidue),
            ("testLogarithm", testLogarithm)
        ]
    }
}
