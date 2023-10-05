import XCTest
@testable import BitVector

class BitVectorTests: XCTestCase {
    func test_append_increments_count() {
        var vector = BitVector()
        vector.append(true)
        vector.append(false)
        vector.append(false)
        vector.append(true)
        XCTAssertEqual(vector.count, 4)
    }
    
    func test_append_resize() {
        var vector = BitVector()
        for value in 0..<1000 {
            vector.append(value.isMultiple(of: 3))
        }
        
        XCTAssertEqual(vector.count, 1000)
        
        for (offset, value) in vector.enumerated() {
            XCTAssertEqual(value, offset.isMultiple(of: 3))
        }
    }
    
    func test_subscript() throws {
        var vector = BitVector()
        vector.append(true)
        vector.append(false)
        vector.append(false)
        vector.append(true)
        
        XCTAssertTrue(vector[0])
        XCTAssertFalse(vector[1])
        XCTAssertFalse(vector[2])
        XCTAssertTrue(vector[3])
    }
    
    func test_description_short() {
        var shortVec = BitVector()
        shortVec.append(true)
        shortVec.append(false)
        shortVec.append(false)
        shortVec.append(true)
        XCTAssertEqual(shortVec.description, "[1001]")
    }
    
    func test_description_longer() {
        var longerVec = BitVector()
        longerVec.append(true)
        longerVec.append(false)
        longerVec.append(false)
        longerVec.append(true)
        longerVec.append(true)
        longerVec.append(false)
        longerVec.append(false)
        longerVec.append(true)
        longerVec.append(true)
        longerVec.append(false)
        longerVec.append(false)
        longerVec.append(true)
        XCTAssertEqual(longerVec.description, "[100110011001]")
    }
}
