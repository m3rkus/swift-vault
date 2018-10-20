
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

// Empty result when you don't care about result value
// Usage:
// func login(with credentials: Credentials, handler: @escaping (_ result: Result<Void>) -> Void) {
//    // Two possible options:
//    handler(Result.success)
//    handler(Result.failure(error: UserError.notFound))
// }
extension Result where T == Void {
    static var success: Result {
        return .success(result: ())
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
