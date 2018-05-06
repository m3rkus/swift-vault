// Power of Enum and Struct

enum MyScreenModel {
  case empty
  case loading
  case data(SomeInfo)
  case failed(Error)
}

extension MyScreenModel {
  var isLoading: Bool {
    guard case .loading = self else { return false }
    return true
  }

  var isEmpty: Bool {
    guard case .empty = self else { return false }
    return true
  }

  var data: SomeInfo? {
    guard let case .data(someInfo) = self else { return nil }
    return someInfo
  }

  var error: Error? {
    guard let case .error(error) = self else { return nil }
    return error
  }
}
