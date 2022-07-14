import XCTest
@testable import TrapezoidShapes

final class TrapezoidShapesTests: XCTestCase {
    func test_RoundedTrapezoid_init() throws {
        XCTAssertEqual(RoundedTrapezoid().cornerRadius, 10)
        XCTAssertEqual(RoundedTrapezoid().flexibleEdgeRatio, 0.65)
        XCTAssertEqual(RoundedTrapezoid().flexibleEdge, .top)
        XCTAssertEqual(RoundedTrapezoid().flexibleEdgeOffset, 0)
    }
}
