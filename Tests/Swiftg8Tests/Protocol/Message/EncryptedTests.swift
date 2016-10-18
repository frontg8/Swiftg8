import XCTest
import Foundation
import class Swiftg8.Error
@testable import class Swiftg8.Encrypted

class EncryptedTests: XCTestCase {

  func testEmptyMessageHasNoContentAndIsNotValidIgnoringErrors() {
    guard let msg = Encrypted() else {
      XCTFail("Could not construct empty message.")
      return
    }

    XCTAssertEqual(msg.content, nil)
    XCTAssert(!msg.valid)
  }

  func testEmptyMessageHasNoContentAndIsNotValidWithErrors() {
    var error = Error()
    guard let msg = Encrypted(&error) else {
      XCTFail("Could not construct empty message.")
      return
    }

    XCTAssertEqual(msg.content, nil)
    XCTAssert(!msg.valid)
  }

  func testSerializingEmptyMessageThrows() {
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

  func testEmptyMessagesCompareEqual() {
    guard let msg1 = Encrypted(), let msg2 = Encrypted() else {
      XCTFail("Could not construct empty messages.")
      return
    }

    XCTAssertEqual(msg1, msg2)
  }

  func testNonEmptyMessageAndEmptyMessageDoNotCompareEqual() {
    guard let empty = Encrypted(), let nonempty = Encrypted(content: "TEST") else {
      XCTFail("Could not construct messages.")
      return
    }

    XCTAssertNotEqual(nonempty, empty)
    XCTAssertNotEqual(empty, nonempty)
  }

  static var allTests = [
    ("testEmptyMessageHasNoContentAndIsNotValidIgnoringErrors", testEmptyMessageHasNoContentAndIsNotValidIgnoringErrors),
    ("testEmptyMessageHasNoContentAndIsNotValidWithErrors", testEmptyMessageHasNoContentAndIsNotValidWithErrors),
    ("testSerializingEmptyMessageThrows", testSerializingEmptyMessageThrows),
    ("testEmptyMessagesCompareEqual", testEmptyMessagesCompareEqual),
    ("testNonEmptyMessageAndEmptyMessageDoNotCompareEqual", testNonEmptyMessageAndEmptyMessageDoNotCompareEqual),
  ]

}
