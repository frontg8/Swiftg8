import Foundation
import Swiftg8

/**
    This function demonstrates how to intialize an `Encrypted` message with a `String` and subsequently retrieve it again.
    There exists an overload for the initializer used in this example that ignores any errors and only returns an optional
    `Encrypted` message.
*/
func DemoEncryptedMessageWithString() {

  var error = Error()
  let message = Encrypted(content: "Hello, frontg8!", &error)
  if message == nil {
    print("Failed to initialize message: ", error.message)
    return
  }

  let content = message!.content
  if content == nil {
    print("Failed to get content of message")
    return
  }

  let text = String(data: content!, encoding: .utf8)!
  print(text)

}

print("Demo: Encrypted message with string:")
DemoEncryptedMessageWithString()
print("===")
