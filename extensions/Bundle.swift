// MARK: - Bundle helpers

extension  Bundle {

    var version: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

}
