//
//  XMLStringFormatter.swift
//  swift-vault
//
//  Created by m3rkus on 04/07/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation

final class XMLStringFormatter {
    
    /**
     * Replace the attributes of xml elements (where the xml tags are formed of 1 single char)
     * with the passed attributes from param `attributesByTags`
     * Support recursive tags (tags in tags)
     * All tags of form '<char>' or '</char>' will be used as formatting (the resulting string
     * should not be expected to have any tags of this form)
     * @param string - target string containing XML tags
     * @param attributesByTags - list of attribute dictionaries, where the key is the tag name
     * @return NSAttributedString object with specified attributes by tags
     
     Usage:
     lblSendAgain.attributedText = XMLStringFormatter().format(
     string: "<r>test</r>",
     with: ["r": [.foregroundColor: UIColor.vmRed]])
     */
    func format(string: String,
                with attributesByTags: [String: [NSAttributedString.Key: Any]]) -> NSAttributedString {
        
        let resultAttributedString = NSMutableAttributedString(string: string)
        
        // apply attributes to tags content
        for tag in attributesByTags.keys {
            let tagContentRegexPattern = "<\(tag)>(.*?)</\(tag)>"
            let tagContentRegexResults = string.scan(regexPattern: tagContentRegexPattern)
            for regexResult in tagContentRegexResults {
                if regexResult.numberOfRanges > 1 {
                    let tagContentRange = regexResult.range(at: 1)
                    guard let attributes = attributesByTags[tag] else {
                        continue
                    }
                    resultAttributedString.addAttributes(attributes,
                                                         range: tagContentRange)
                }
            }
        }
        
        // remove tags from the string
        let tagRegexPattern = "<[^>]*>"
        var tagRegexResults: [NSTextCheckingResult] = []
        tagRegexResults = string.scan(regexPattern: tagRegexPattern)
        while !tagRegexResults.isEmpty {
            
            if let regexResult = tagRegexResults.first,
                regexResult.numberOfRanges > 0 {
                
                let tagRange = regexResult.range(at: 0)
                resultAttributedString.replaceCharacters(in: tagRange, with: "")
            }
            tagRegexResults = resultAttributedString.string.scan(regexPattern: tagRegexPattern)
        }
        return resultAttributedString
    }
}
