//
//  Extensions.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/09/2021.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static let divider: CGFloat = 255.0
    
    static func fill(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / divider, green: green / divider, blue: blue / divider, alpha: alpha)
    }
    
    static func fill(white: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(white: white / divider, alpha: alpha)
    }
    
    struct Theme {
        static let green = UIColor(hexString: "578719")
    }
    
}

extension UIFont {
    
    public enum FontType: String {
        
        case none = ""
        
        case light = "-Light"
        case lightItalic = "-LightItalic"
        case extraLight = "-ExtraLight"
        case extraLightItalic = "-ExtraLightItalic"
        
        case thin = "-Thin"
        case thinItalic = "-ThinItalic"
        
        case medium = "-Medium"
        
        case bold = "-Bold"
        case boldItalic = "-BoldItalic"
        case semiBold = "-SemiBold"
        case semiBoldItalic = "-SemiBoldItalic"
        case extraBold = "-ExtraBold"
        case extraBoldItalic = "-ExtraBoldItalic"
        
        case regular = "-Regular"
        case black = "-Black"
        case blackItalic = "-BlackItalic"
        
    }
    
    static func Poppins(_ type: FontType = .none, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Poppins\(type.rawValue)", size: size)!
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setPadding(_ amount: CGFloat = 10.0) {
        self.setLeftPaddingPoints(amount)
        self.setRightPaddingPoints(amount)
    }
}

extension UIStoryboard {
    convenience init(storyboard: Storyboard) {
        self.init(name: storyboard.rawValue, bundle: nil)
    }
}

extension UIView {
    func roundView() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadowWithOffset(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadowDown() {
         dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 0.0, height: 2.0), radius: 2, scale: true)
    }
    
    func anchor(centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?,  paddingX: CGFloat, paddingY: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX, constant: paddingX).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY, constant: paddingY).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}

protocol Backable {
    func setupBackButton(color: UIColor)
}

extension UIViewController: Backable, StoryboardIdentifiable {
    
    func setupBackButton(color: UIColor) {
        navigationItem.hidesBackButton = true
        let backBtn = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(self.backButtonHandler))
        backBtn.tintColor = color
        navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc func backButtonHandler() {
        self.navigationController?.popViewController(animated:true)
    }
    
}

extension UIViewController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        switch (navigationController, viewController) {
//        case (_, is HomeViewController):             
//            navigationController.setNavigationBarHidden(true, animated: true)
        default:
            navigationController.setNavigationBarHidden(false, animated: true)
        }

    }
}

extension UITableViewCell: NibLoadable {
    
}

extension UICollectionViewCell: NibLoadable {
    
}
