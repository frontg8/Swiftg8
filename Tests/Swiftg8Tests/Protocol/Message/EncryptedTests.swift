import XCTest
import Foundation
import class Swiftg8.Error
@testable import class Swiftg8.Encrypted

class EncryptedTests: XCTestCase {

  func testEmptyMessage() {
    let msg = Encrypted()!
    XCTAssertEqual(msg.content, nil)
    XCTAssert(!msg.valid)
  }

  func testEmptyMessageWithError() {
    var error = Error()
    let msg = Encrypted(&error)!
    XCTAssertEqual(msg.content, nil)
    XCTAssert(!msg.valid)
  }

  func testSerializeEmptyMessage() {
    let msg = Encrypted()!
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
