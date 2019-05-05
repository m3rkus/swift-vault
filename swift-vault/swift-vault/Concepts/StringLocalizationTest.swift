//
//  StringLocalizationTest.swift
//  swift-vault
//
//  Created by Роман Анистратенко on 05/05/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation


final class LocalizaitonTests {

    /// test only base language, improve later to test all supported languages
    func testLocalization() {
        
        let localizationKeys = Localizable.allCases
        
        for keyCase in localizationKeys {
            let key = keyCase.rawValue
            let localizedString = NSLocalizedString(key, comment: "")
//            XCTAssertNotEqual(key, localizedString, "key \(key) isn't localized")
        }
    }
}
