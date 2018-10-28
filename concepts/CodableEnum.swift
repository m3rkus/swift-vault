enum DisplayName {
    case firstName
    case secondName
    case fullName
}

extension DisplayName: Codable {

    enum Key: CodingKey {
        case rawValue
    }

    enum CodingError: Error {
        case unknownValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            self = .firstName
        case 1:
            self = .secondName
        case 2:
            self = .fullName
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .firstName:
            try container.encode(0, forKey: .rawValue)
        case .secondName:
            try container.encode(1, forKey: .rawValue)
        case .fullName:
            try container.encode(2, forKey: .rawValue)
        }
    }

}
