import CFrontg8
import Foundation

public class Encrypted {

  internal let cEncrypted: OpaquePointer?

  /**
      Initialize an encrypted message with a given string, ignoring any errors

      - Parameter content: The content of the new message

      - Returns: An optional of type `Encrypted`

      - Note: All errors during instanciation of the underlying object are ignored. If you need to know what went wrong,
          consider using `init?(content: String, _: inout Error)`
  */
  public convenience init?() {
    var ignored = Error()
    self.init(&ignored)
  }

  /**
      Initialize an encrypted message with a given string

      - Parameter content: The content of the new message
      - Parameter error: An object containing an error if one occured

      - Returns: An optional of type `Encrypted`
  */
  public init?(_ error: inout Error) {
    var cError: OpaquePointer?
    cEncrypted = fg8_protocol_message_encrypted_create(nil, 0, &cError)

    if cError != nil {
      error = Error(cError)
      return nil
    }
  }

  /**
      Initialize an encrypted message with a given string, ignoring any errors

      - Parameter content: The content of the new message

      - Returns: An optional of type `Encrypted`

      - Note: All errors during instanciation of the underlying object are ignored. If you need to know what went wrong,
          consider using `init?(content: String, _: inout Error)`
  */
  public convenience init?(content: String) {
    var ignored = Error()
    self.init(content: content, &ignored)
  }

  /**
      Initialize an encrypted message with a given string

      - Parameter content: The content of the new message
      - Parameter error: An object containing an error if one occured

      - Returns: An optional of type `Encrypted`
  */
  public init?(content: String, _ error: inout Error) {
    var cError: OpaquePointer?

    cEncrypted = fg8_protocol_message_encrypted_create(content, content.utf8CString.count, &cError)

    if cError != nil {
      error = Error(cError)
      return nil
    }
  }

  /**
      Initialize an encrypted message with the given data, ignoring any errors

      - Parameter content: The content of the new message

      - Returns: An optional of type `Encrypted`

      - Note: All errors during instanciation of the underlying object are ignored. If you need to know what went wrong,
          consider using `init?(content: Data, _: inout Error)`
  */
  public convenience init?(content: Data) {
    var ignored = Error()
    self.init(content: content, &ignored)
  }

  /**
      Initialize an encrypted message with the given data

      - Parameter content: The content of the new message
      - Parameter error: An object containing an error if one occured

      - Returns: An optional of type `Encrypted`
  */
  public init?(content: Data, _ error: inout Error) {
    var cError: OpaquePointer?
    var cPointer: OpaquePointer?

    content.withUnsafeBytes{ (bytes: UnsafePointer<Int8>) -> Void in
      cPointer = fg8_protocol_message_encrypted_create(bytes, content.count, &cError)
    }
    cEncrypted = cPointer

    if cError != nil {
      error = Error(cError)
      return nil
    }
  }

  /**
      Initialize an encrypted message by deserializing it from the given data, ignoring any errors

      - Parameter serializedData: The data of a serialized data

      - Returns: An optional of type `Encrypted`

      - Note: All errors during instanciation of the underlying object are ignored. If you need to know what went wrong,
          consider using `init?(serializedData: String, _: inout Error)`
  */
  public convenience init?(serializedData: Data) {
    var ignored = Error()
    self.init(content: serializedData, &ignored)
  }

  /**
      Initialize an encrypted message with the given data

      - Parameter serializedData: The data of a serialized data
      - Parameter error: An object containing an error if one occured

      - Returns: An optional of type `Encrypted`
  */
  public init?(serializedData: Data, _ error: inout Error) {
    var cError: OpaquePointer?
    var cPointer: OpaquePointer?

    serializedData.withUnsafeBytes{ (bytes: UnsafePointer<Int8>) -> Void in
      cPointer = fg8_protocol_message_encrypted_deserialize(bytes, serializedData.count, &cError)
    }
    cEncrypted = cPointer

    if cError != nil {
      error = Error(cError)
      return nil
    }
  }

  /**
      Copy an existing `Encrypted` message, ignoring all errors

      - Parameter _: The `Encrypted` message to copy

      - Returns: An optional of type `Encrypted`

      - Note: All errors during copying of the underlying object are ignored. If you need to know what went wrong, consider
          using `init?(_: Encrypted, _: inout Error)`
  */
  public convenience init?(_ copyFrom: Encrypted) {
    var ignored = Error()
    self.init(copyFrom, &ignored)
  }

  /**
      Copy an existing `Encrypted` message

      - Parameter _: The `Encrypted` message to copy

      - Returns: An optional of type `Encrypted`
  */
  public init?(_ copyFrom: Encrypted, _ error: inout Error) {
    var cError: OpaquePointer?
    cEncrypted = fg8_protocol_message_encrypted_copy(copyFrom.cEncrypted, &cError)

    if cError != nil {
      error = Error(cError)
      return nil
    }
  }

  deinit {
    fg8_protocol_message_encrypted_destroy(cEncrypted)
  }

  /**
      Serialize the `Encrypted` message to `Data` suitable for storig on disk or transferring via the network

      - Returns: A object of type `Data` that contains the bytes representing an `Encrypted` message

      - Throws: `Error` if serialization fails
  */
  public func serialize() throws -> Data {
    var cSize = 0
    var cError: OpaquePointer?
    let cData = fg8_protocol_message_encrypted_serialize(cEncrypted, &cSize, &cError)
    if cError != nil {
      throw Error(cError)
    }

    return Data(bytesNoCopy: cData!, count: cSize, deallocator: .free)
  }

  /**
      Get/Set the content of the `Encrypted` message
  */
  public var content: Data? {
    get {
      var cSize = 0
      var cError: OpaquePointer?
      let cData = fg8_protocol_message_encrypted_get_content(cEncrypted, &cSize, &cError)

      if cError != nil || cSize == 0 || cData == nil {
        return nil
      }

    return Data(bytes: cData!, count: cSize)
    }

    set(data) {
      if data != nil {
        var cError: OpaquePointer?
        data?.withUnsafeBytes{ (bytes:UnsafePointer<CChar>) -> Void in
          fg8_protocol_message_encrypted_set_content(cEncrypted, bytes, data!.count, &cError)
        }
      }
    }
  }

  /**
      Check if the `Encrypted` message is in a valid state (e.g has content)
  */
  public var valid: Bool {
    get {
      return fg8_protocol_message_encrypted_is_valid(cEncrypted)
    }
  }

}

extension Encrypted: Equatable {
  public static func == (lhs: Encrypted, rhs: Encrypted) -> Bool {
    return fg8_protocol_message_encrypted_compare_equal(lhs.cEncrypted, rhs.cEncrypted)
  }
}

