extension UserDefaults {

    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }

    subscript<T: RawRepresentable>(key: String) -> T? {
         get {
             if let rawValue = value(forKey: key) as? T.RawValue {
                 return T(rawValue: rawValue)
             }
             return nil
         }
         set {
             set(newValue?.rawValue, forKey: key)
         }
    }
}

// TODO: - Add default values
// TODO: - Add Codable support

class SettingsService {

    enum AppTheme: Int {
        case light
        case dark
    }

    var isNotificationsEnabled: Bool {
        get {
            return UserDefaults.standard[#function] ?? true
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }

    var appTheme: AppTheme {
        get {
            return UserDefaults.standard[#function] ?? .light
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
}
