import XCTest
import Foundation
import class Swiftg8.Error
@testable import class Swiftg8.Encrypted

class EncryptedTests: XCTestCase {

  func testEmptyMessage() {
    guard let msg = Encrypted() else {
      XCTFail("Could not construct empty message.")
      return
    }

    XCTAssertEqual(msg.content, nil)
    XCTAssert(!msg.valid)
  }

  func testEmptyMessageWithError() {
    var error = Error()
    guard let msg = Encrypted(&error) else {
      XCTFail("Could not construct empty message.")
      return
    }

    XCTAssertEqual(msg.content, nil)
    XCTAssert(!msg.valid)
  }

  func testSerializeEmptyMessage() {
    guard let msg = Encrypted() else {
      XCTFail("Could not construct empty message.")
      return
    }

    do {
      let _ = try msg.serialize()
      XCTFail("Should have thrown")
    } catch {
      XCTAssert(true)
    }

    XCTAssertEqual(msg.content, nil)
    XCTAssert(!msg.valid)
  }

  static var allTests : [(String, (EncryptedTests) -> () throws -> Void)] {
    return [
      ("Empty initialized message has 'nil' content and is invalid (ignoring errors)", testEmptyMessage),
      ("Empty initialized message has 'nil' content and is invalid", testEmptyMessageWithError),
      ("Empty initialized message thows on serialization", testSerializeEmptyMessage),
    ]
  }

}
