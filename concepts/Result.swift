
/// Result abstraction type

enum Result<Value, CommonError> {

    case value(Value)
    case error(CommonError)

    var value: Value? {
        switch self {
        case .value(let value):
            return value
        case .error:
            return nil
        }
    }

    var error: CommonError? {
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

}

// Usage: let user = try result.decoded() as User
extension Result where Value == Data {

    func decoded<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        let data = try resolve()
        return try decoder.decode(T.self, from: data)
    }

}
