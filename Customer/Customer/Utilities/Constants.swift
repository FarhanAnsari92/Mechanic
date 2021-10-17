//
//  Constants.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/09/2021.
//

import UIKit

class Constants {
    
//    static let googleApiKey = "AIzaSyBVtXGQOc5ak14HfguBRmtLAY9WfQHAWOE"
    
    struct Screen {
        static var width: CGFloat {
            return UIScreen.main.bounds.width
        }
        static var height: CGFloat {
            return UIScreen.main.bounds.height
        }
        static var statusBarHeight: CGFloat {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    struct Observer {
        static let internetConnected    = "internetConnected"
    }
    
    struct RegularExpression {
        static let mobileNumber          = "^\\d{0,11}$"
        static let email                 = "[A-Z\\da-z._%+-]+@[A-Za-z\\d.-]+\\.[A-Za-z]{2,64}"
        static let name                  = "^[A-Za-z\\s]{0,50}$"
        static let pinCode               = "^\\d{0,4}$"
        static let alphaNumeric          = "^[A-Za-z\\d]{0,24}$"
        static let alphaNumericWithSpace = "^[A-Za-z\\d\\s]{0,50}$"
        static let iban                  = "^[A-Za-z]{2}\\d{2}[A-Za-z\\d]{4}\\d{16}$"
        static let cnic                  = "^\\d{0,13}$"
        static let deliveryAmount        = "^\\d{0,5}$"
        static let orderNumber           = "^[A-Za-z\\d]{0,20}$"
        static let withdrawMobileAmount  = "^\\d{0,6}$"
        static let withdrawBankAmount    = "^\\d{0,6}$"
        static let billAmount            = "^\\d{0,5}$"
        static let coordinate            = "\\d+\\.\\d+\\s*,\\s*\\d+\\.\\d+"
    }
    
    struct Device {
        static let type: String = "ios"
    }
    
    static let role: String = "13"
    
}

enum TextFieldType {
    case mobileNumber
    case email
    case name
    case pinCode
    case alphaNumeric
    case alphaNumericWithSpace
    case iban
    case cnic
}
