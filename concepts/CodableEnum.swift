enum DisplayName {
    case firstName
    case secondName
    case fullName
}

// MARK: - Codable
extension DisplayName: Codable {
    
    enum CodingError: Error {
        case unknownValue
    }
    
    private var codableValue: String {
        switch self {
        case .firstName:
            return "first_name"
        case .secondName:
            return "second_name"
        case .fullName:
            return "full_name"
        }
    }
    
    init(from decoder: Decoder) throws {
        let rawValue = try decoder.singleValueContainer().decode(String.self)
        
        switch rawValue {
        case DisplayName.firstName.codableValue:
            self = .firstName
        case DisplayName.secondName.codableValue:
            self = .secondName
        case DisplayName.fullName.codableValue:
            self = .fullName
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .firstName:
            try container.encode(DisplayName.firstName.codableValue)
        case .secondName:
            try container.encode(DisplayName.secondName.codableValue)
        case .fullName:
            try container.encode(DisplayName.fullName.codableValue)
        }
    }
    
}