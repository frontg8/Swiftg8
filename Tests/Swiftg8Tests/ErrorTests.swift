import XCTest
@testable import class Swiftg8.Error

class ErrorTests: XCTestCase {
  func testMessage() {
    XCTAssertEqual(Error().message, "")
  }

  static var allTests : [(String, (ErrorTests) -> () throws -> Void)] {
    return [
      ("testMessage", testMessage),
    ]
  }
}
