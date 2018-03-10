// Result abstraction type


enum Result<T, E> {

    case value(T)
    case error(E)

    var value: T? {
        switch self {
        case .value(let value):
            return value
        case .error:
            return nil
        }
    }

    var error: E? {
        switch self {
        case .error(let error):
            return error
        case .value:
            return nil
        }
    }

    var isError: Bool {
        switch self {
        case .error:
            return true
        case .value:
            return false
        }
    }

    func onValue(_ closure: (T) -> ()) {
        if let value = value {
            closure(value)
        }
    }

    func onError(_ closure: (E) -> ()) {
        if let error = error {
            closure(error)
        }
    }

    func map<U>(_ transform: (T) throws -> U) rethrows -> Result<U, E> {
        switch self {
        case .value(let value):
            return try .value(transform(value))
        case .error(let error):
            return .error(error)
        }
    }

    func flatMap<U>(_ transform: (T) throws -> Result<U, E>) rethrows -> Result<U, E> {
        switch self {
        case .value(let value):
            return try transform(value)
        case .error(let error):
            return .error(error)
        }
    }
}
