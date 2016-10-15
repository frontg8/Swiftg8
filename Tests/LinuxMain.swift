import XCTest
@testable import Swiftg8Tests

XCTMain([
  testCase(ErrorTests.allTests),
  testCase(EncryptedTests.allTests),
])
