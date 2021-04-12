    import XCTest
    @testable import HTTPKit

    final class HTTPKitTests: XCTestCase {
        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
            XCTAssertEqual(HTTPKit().text, "Hello, World!")
        }
    }
