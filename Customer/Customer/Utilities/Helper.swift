//
//  Helper.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 26/09/2021.
//

import UIKit
import MBProgressHUD

class Helper {
    
    class func delay(_ delay:Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    class func showMessage(text: String) {
        DispatchQueue.main.async {
            
            let progressHud = MBProgressHUD.showAdded(to: UIApplication.shared.windows.first!, animated: true)            
            
            progressHud.backgroundColor = UIColor(white: 0, alpha: 0)
            
            progressHud.detailsLabel.text = text
            // Setting up the mode of MBProgressHUD
            progressHud.mode = .text
            // Hide message automatically after 2 seconds
            progressHud.hide(animated: true, afterDelay: 2.0)
            
        }
    }
    
    class func formatCurrency(value: Int?) -> String? {
        guard  let intValue = value else {
            return nil
        }
        let number = NSNumber(value: intValue)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedCurrency = numberFormatter.string(from: number) else {
            return nil
        }
        return formattedCurrency
    }
    
    class func save(user: UserModel) {
        UserDefaults.standard.setValue(user.toJSONString(), forKey: "user")
    }
    
    class func getUser() -> UserModel? {
        if let strUser = UserDefaults.standard.string(forKey: "user") {
            let user = ObjectMapperManager<UserModel>().map(string: strUser)
            return user
        }
        return nil
    }
    
    class func removeUser() {
        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    class func logout() {
        Helper.removeUser()
    }
    
}
