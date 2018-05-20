import UIKit


struct Application {

    fileprivate static func getString(_ key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary[key] as? String
            else { return "" }

        return value
    }

    static var name: String = {
        let displayName = Application.getString("CFBundleDisplayName")

        return !displayName.isEmpty ? displayName : Application.getString("CFBundleName")
    }()

    static var version: String = {
        return Application.getString("CFBundleShortVersionString")
    }()

    static var build: String = {
        return Application.getString("CFBundleVersion")
    }()

    static var bundle: String = {
        return Application.getString("CFBundleIdentifier")
    }()

}
