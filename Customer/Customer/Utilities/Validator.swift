//
//  Validator.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 17/10/2021.
//

import Foundation

class Validator: NSObject {

    /// Validate mobile number
    ///
    /// - Parameter mobileNumber: String
    /// - Returns: Bool
    class func validate(mobile number: String) -> Bool {
        // Validating mobile number length entered using regular expression by a predicate
        let mobileNumberPredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.mobileNumber)
        return mobileNumberPredicate.evaluate(with: number)
    }

    /// Validate email address formatting
    ///
    /// - Parameter email: String
    /// - Returns: Bool
    class func validate(email emailAddress: String) -> Bool {
        // Validating email address using regular expression by a predicate
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.email)
        return emailPredicate.evaluate(with: emailAddress)
    }

    /// Validate name formatting
    ///
    /// - Parameter name: String
    /// - Returns: Bool
    class func validate(name fullName: String) -> Bool {
        // Validating name using regular expression by a predicate
        let namePredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.name)
        return namePredicate.evaluate(with: fullName)
    }

    /// Validate pin code formatting
    ///
    /// - Parameter code: String
    /// - Returns: Bool
    class func validate(pin code: String) -> Bool {
        // Validating pin code using regular expression by a predicate
        let pinCodePredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.pinCode)
        return pinCodePredicate.evaluate(with: code)
    }

    /// Validate alphanumeric formatting
    ///
    /// - Parameter text: String
    /// - Returns: Bool
    class func validate(alphaNumeric text: String) -> Bool {
        // Validating alphanumeric using regular expression by a predicate
        let alphaNumericPredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.alphaNumeric)
        return alphaNumericPredicate.evaluate(with: text)
    }

    /// Validate alphanumeric with space formatting
    ///
    /// - Parameter text: String
    /// - Returns: Bool
    class func validate(alphaNumericWithSpace text: String) -> Bool {
        // Validating alphanumeric with space using regular expression by a predicate
        let alphaNumericWithSpacePredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.alphaNumericWithSpace)
        return alphaNumericWithSpacePredicate.evaluate(with: text)
    }

    /// Validate IBAN formatting
    ///
    /// - Parameter number: String
    /// - Returns: Bool
    class func validate(iban number: String) -> Bool {
        // Validating IBAN using regular expression by a predicate
        let ibanPredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.iban)
        return ibanPredicate.evaluate(with: number)
    }

    /// Validate CNIC formatting
    ///
    /// - Parameter number: String
    /// - Returns: Bool
    class func validate(cnic number: String) -> Bool {
        // Validating CNIC using regular expression by a predicate
        let cnicPredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.cnic)
        return cnicPredicate.evaluate(with: number)
    }

    /// Validate order number formatting
    ///
    /// - Parameter number: String
    /// - Returns: Bool
    class func validate(orderNumber number: String) -> Bool {
        // Validating order number using regular expression by a predicate
        let orderNumberPredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.orderNumber)
        return orderNumberPredicate.evaluate(with: number)
    }

    /// Validate payment request mobile amount
    ///
    /// - Parameter amount: String
    /// - Returns: Bool
    class func validate(withdrawMobile amount: String) -> Bool {
        // Validating payment request mobile amount using regular expression by a predicate
        let paymentRequestMobileAmountPredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.withdrawMobileAmount)
        return paymentRequestMobileAmountPredicate.evaluate(with: amount)
    }

    /// Validate payment request bank amount
    ///
    /// - Parameter amount: String
    /// - Returns: Bool
    class func validate(withdrawBank amount: String) -> Bool {
        // Validating payment request bank amount using regular expression by a predicate
        let paymentRequestBankAmountPredicate = NSPredicate(format:"SELF MATCHES %@", Constants.RegularExpression.withdrawBankAmount)
        return paymentRequestBankAmountPredicate.evaluate(with: amount)
    }
    
    /// Valid customer name and number in single string
    ///
    /// - Parameter text: String
    /// - Returns: Bool
    class func validDetails(_ text: String?) -> Bool {
        guard let text = text, text.count > 0 else {
            return false
        }
        if text.split(separator: " ").last == nil {
            return false
        }
        let number = String(text.split(separator: " ").last!)
        if number.count != 11 || number.hasPrefix("03") == false {
            return false
        }
        if Validator.validateTextField(number, .mobileNumber) {
            return true
        } else {
            return false
        }
    }

    /// Validate text fields according to the enum TextFieldType
    ///
    /// - Parameters:
    ///   - text: String
    ///   - type: TextFieldType
    /// - Returns: Bool
    class func validateTextField(_ text: String, _ type: TextFieldType) -> Bool {
        switch type {
        case .mobileNumber:
            // Validating mobile number text field
            return Validator.validate(mobile: text)
        case .email:
            // Validating email address text field
            return Validator.validate(email: text)
        case .name:
            // Validating name text field
            return Validator.validate(name: text)
        case .pinCode:
            // Validating pin code text field
            return Validator.validate(pin: text)
        case .alphaNumeric:
            // Validating alphanumeric text field
            return Validator.validate(alphaNumeric: text)
        case .alphaNumericWithSpace:
            // Validating alphanumeric with space text field
            return Validator.validate(alphaNumericWithSpace: text)
        case .iban:
            // Validating IBAN text field
            return Validator.validate(iban: text)
        case .cnic:
            // Validating CNIC text field
            return Validator.validate(cnic: text)
        }
    }
}
