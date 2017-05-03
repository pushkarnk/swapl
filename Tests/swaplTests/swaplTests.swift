import XCTest
@testable import swapl

class swaplTests: XCTestCase {

    func testConjugate() {
        XCTAssert(➕[1, 2, 3] == [1, 2, 3])
        XCTAssert(➕[1] == [1])
        XCTAssert(➕[1.2] == [1.2])
        XCTAssert(➕[1.2,3.2,0,1.2] == [1.2,3.2,0,1.2])
    }

    func testPlus() {
        XCTAssert([1] ➕ [2] == [3])
        XCTAssert([1] ➕ [1,2,3] == [2, 3, 4])
        XCTAssert([1,2,3,4] ➕ [9] == [10, 11, 12, 13])
        XCTAssert([1,2] ➕ [4,5] == [5,7])
    }

    func testNegate() {
        XCTAssert(➖[1.2, -1, 0] == [-1.2, 1, 0])
        XCTAssert(➖[10] == [-10])
        let a: [Double] = [1,2,3,4,5,6]
        XCTAssert(➖(➖a) == a)
    }

    func testMinus() {
        let a1: [Double] = [1], w1 = [Double]([1, 2, 3, 4])
        XCTAssert(a1➖w1 == [0, -1, -2, -3])

        let a2: [Double] = [1, 2, 3, 4], w2 = [Double]([1])
        XCTAssert(a2➖w2 == [0, 1, 2, 3])

        let a3: [Double] = [10, 9, 8], w3 = [Double]([3, 2, 5])
        XCTAssert(a3➖w3 == [7,7,3])
    }

    func testDirection() {
        let a1 = [Double]([-1, 2, 9, 124, -91, 0, -199])
        XCTAssert(✖️a1 == [-1, 1, 1, 1, -1, 0, -1])
    }

    func testTimes() {
        let a1 = [Double]([2]), w1 = [Double]([2])
        XCTAssert(a1✖️w1 == [4])
        let a2 = [Double]([2, 4, 8]), w2 = [Double]([2])
        XCTAssertEqual(a2✖️w2, [4, 8, 16])
        let a3 = [Double]([2]), w3 = [Double]([2,4,8])
        XCTAssertEqual(a3✖️w3, [4, 8, 16])
        let a4 = [Double]([2, 4, 8]), w4 = [Double]([2, 4, 8])
        XCTAssertEqual(a4✖️w4, [4, 16, 64])
    }

    func testReciprocal() {
        let a1 = [Double]([1, 2, 4, 5])
        XCTAssert(➗a1 == [1, 0.5, 0.25, 0.2])
    }

    func testDivide() {
        let a1 = [Double]([2]), w1 = [Double]([2])
        XCTAssert(a1➗w1 == [1])
        let a2 = [Double]([2, 4, 8]), w2 = [Double]([2])
        XCTAssertEqual(a2➗w2, [1, 2, 4])
        let a3 = [Double]([2]), w3 = [Double]([2,4,8])
        XCTAssertEqual(a3➗w3, [1, 0.5, 0.25])
        let a4 = [Double]([2, 4, 8]), w4 = [Double]([1, 2, 5])
        XCTAssertEqual(a4➗w4, [2, 2, 1.6])
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
        ]
    }
}
