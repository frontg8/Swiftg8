import CFrontg8

public class Error : Swift.Error {

  internal let cError: OpaquePointer?

  public init() {
    cError = OpaquePointer(bitPattern: 0)
  }

  internal init(_ cError: OpaquePointer?) {
    self.cError = cError
  }

  deinit {
    fg8_error_destroy(cError)
  }

  public var message: String {
    let cStr = fg8_error_message(cError)
    if  cStr != nil {
      return String(cString: cStr!)
    }

    return ""
  }

}
