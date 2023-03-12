//
//  Validators.swift
//  MyNews
//
//  Created by Aksilont on 19.02.2023.
//

import Foundation

final class Validators {
    
    static func isFilled(_ arrayOfStrings: String? ...) -> Bool {
        for item in arrayOfStrings {
            guard let item else { return false }
            if item.isEmpty { return false }
        }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
