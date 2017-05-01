import XCTest
@testable import swapl

class swaplTests: XCTestCase {

    func testPlusMonadic() {
        XCTAssert(➕[1, 2, 3] == [1, 2, 3])
        XCTAssert(➕[1] == [1])
        XCTAssert(➕[1.2] == [1.2])
        XCTAssert(➕[1.2,3.2,0,1.2] == [1.2,3.2,0,1.2])
    }

    func testPlusDiadic() {
        XCTAssert([1] ➕ [2] == [3])
        XCTAssert([1] ➕ [1,2,3] == [2, 3, 4])
        XCTAssert([1,2,3,4] ➕ [9] == [10, 11, 12, 13])
        XCTAssert([1,2] ➕ [4,5] == [5,7])
    }

    static var allTests : [(String, (swaplTests) -> () throws -> Void)] {
        return [
            ("testPlusMonadic", testPlusMonadic),
            ("testPlusDiadic", testPlusDiadic),
        ]
    }
}
