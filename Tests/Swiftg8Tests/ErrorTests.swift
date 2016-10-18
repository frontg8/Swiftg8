import XCTest
@testable import class Swiftg8.Error

class ErrorTests: XCTestCase {
  func testEmptyErrorHasEmptyMessage() {
    XCTAssertEqual(Error().message, "")
  }

  static var allTests = [
    ("testEmptyErrorHasEmptyMessage", testEmptyErrorHasEmptyMessage),
  ]
}
