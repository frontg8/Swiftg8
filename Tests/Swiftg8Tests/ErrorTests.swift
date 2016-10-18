import XCTest
@testable import class Swiftg8.Error

class ErrorTests: XCTestCase {
  func testEmptyErrorHasEmptyMessage() {
    XCTAssertEqual(Error().message, "")
  }

  static var allTests : [(String, (ErrorTests) -> () throws -> Void)] {
    return [
      ("An empty error returns an empty message", testEmptyErrorHasEmptyMessage),
    ]
  }
}
