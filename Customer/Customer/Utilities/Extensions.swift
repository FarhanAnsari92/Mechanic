//
//  Extensions.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/09/2021.
//

import UIKit
import MBProgressHUD

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

extension UISegmentedControl {
    func setupDashboardSegment() {
        self.layer.borderColor = UIColor.Theme.green.cgColor
        self.layer.borderWidth = 1
//        setDividerImage(tintColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
//        self.setDividerImage(UIImage(cgImage: UIColor.Theme.green as! CGImage), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        if #available(iOS 13.0, *) {
            self.selectedSegmentTintColor = .white
        } else {
            print("fallback-------------")
        }
        self.backgroundColor = .white
        self.tintColor = .white
        
        let selectedAtt = [NSAttributedString.Key.foregroundColor: UIColor.Theme.green]
        self.setTitleTextAttributes(selectedAtt, for: .selected)
        
        let deselectedAtt = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.setTitleTextAttributes(deselectedAtt, for: .normal)
    }
}

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){

        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        cgPath = path
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

extension Data {
     var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIView {
    
    func showHud() {
        MBProgressHUD.showAdded(to: self, animated: true)
    }
    
    func hideHud() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self, animated: true)
        }
    }
    
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
    
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
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
        if (self.navigationController?.viewControllers.count == 1) {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
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

enum DateFormat: String {
    case standardFormat = "d MMM yyyy" // 9 Nov 2021
}

extension Notification.Name {
    static let updateProducts = Notification.Name("UPDATE_PRODUCTS")
}

extension String {
    
    func toFormattedDate(format: DateFormat) -> String? {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(self)
        let dt: Date? = dateFormate.date(from: self)
        dateFormate.dateFormat = format.rawValue
        if let date = dt {
            return dateFormate.string(from: date)
        } else {
            return nil
        }
    }
    
}

extension UITableViewCell: NibLoadable {
    
}

extension UICollectionViewCell: NibLoadable {
    
}
