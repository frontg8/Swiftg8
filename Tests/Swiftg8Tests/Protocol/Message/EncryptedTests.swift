import XCTest
import Foundation
import class Swiftg8.Error
@testable import class Swiftg8.Encrypted

class EncryptedTests: XCTestCase {

  func testDefaultInitializedMessageHasNoContentAndIsNotValidIgnoringErrors() {
    guard let msg = Encrypted() else {
      XCTFail("Could not construct empty message.")
      return
    }

    XCTAssertEqual(msg.content, nil)
    XCTAssert(!msg.valid)
  }

  func testDefaultInitializedMessageHasNoContentAndIsNotValidWithErrors() {
    var error = Error()
    guard let msg = Encrypted(&error) else {
      XCTFail("Could not construct empty message.")
      return
    }

    XCTAssertEqual(msg.content, nil)
    XCTAssert(!msg.valid)
  }

  func testSerializingDefaultInitializedMessageThrows() {
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

  func testDefaultInitializedMessagesCompareEqual() {
    guard let msg1 = Encrypted(), let msg2 = Encrypted() else {
      XCTFail("Could not construct empty messages.")
      return
    }

    XCTAssertEqual(msg1, msg2)
  }

  func testNonEmptyMessageAndDefaultInitializedMessageDoNotCompareEqual() {
    guard let empty = Encrypted(), let nonempty = Encrypted(content: "TEST") else {
      XCTFail("Could not construct messages.")
      return
    }

    XCTAssertNotEqual(nonempty, empty)
    XCTAssertNotEqual(empty, nonempty)
  }

  func testSerializingEmptyMessageDoesNotThrow() {
    guard let message = Encrypted(content: Data()) else {
      XCTFail("Could not construct messages.")
      return
    }

    do {
      let serialized = try message.serialize()
      XCTAssertEqual(Data(bytes: [0x0a, 0x00]), serialized)
    } catch {
      XCTFail("Serialization should not have thrown")
    }
  }

  func testSerializingMessageWithEmptyStringIgnoresTrailingNullByte() {
    guard let message = Encrypted(content: "") else {
      XCTFail("Could not construct messages.")
      return
    }

    do {
      let serialized = try message.serialize()
      XCTAssertEqual(2, serialized.count)
      XCTAssertEqual(Data(bytes: [0x0a, 0x00]), serialized)
    } catch {
      XCTFail("Serialization should not have thrown")
    }
  }

  static var allTests = [
    ("testDefaultInitializedMessageHasNoContentAndIsNotValidIgnoringErrors",
      testDefaultInitializedMessageHasNoContentAndIsNotValidIgnoringErrors),
    ("testEmptyMessageHasNoContentAndIsNotValidWithErrors",
      testDefaultInitializedMessageHasNoContentAndIsNotValidWithErrors),
    ("testSerializingDefaultInitializedMessageThrows",
      testSerializingDefaultInitializedMessageThrows),
    ("testDefaultInitializedMessagesCompareEqual",
      testDefaultInitializedMessagesCompareEqual),
    ("testNonEmptyMessageAndDefaultInitializedMessageDoNotCompareEqual",
      testNonEmptyMessageAndDefaultInitializedMessageDoNotCompareEqual),
    ("testSerializingEmptyMessageDoesNotThrow",
      testSerializingEmptyMessageDoesNotThrow),
    ("testSerializingMessageWithEmptyStringIgnoresTrailingNullByte",
      testSerializingMessageWithEmptyStringIgnoresTrailingNullByte),
  ]

}
