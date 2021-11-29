//
//  AppDelegate.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/09/2021.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var instance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var isPickupSelected: Bool = true
    var deviceToken: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /*
         -- CREDENTIAL
         03352266407 customer pwd 1-7
         03472455159 mechanic pwd 1-7
         */
        
        #if Customer
        print("---- customer")
        #else
        print("---- mechanic")
        #endif
        
        GMSServices.provideAPIKey(Constants.Google.mapAPIKey)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [ChatViewController.self]
        AppRoute.navigateUserAppropriately()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let _deviceToken = deviceToken
        self.deviceToken = _deviceToken.hexString
    }

}

class ReachabilityManager {
    
    var window: UIWindow?
    
    init() {
        let reachability = NetworkReachabilityManager()
        reachability?.startListening()
        reachability?.listener = { [weak self] status in
            switch status {
            case .notReachable:
                
                self?.internetConnected = false
                
            case .reachable(_), .unknown:
                self?.internetConnected = true
            }
        }
    }
    
    func setup(window: UIWindow?) {
        self.window = window
    }
    
    private var _internetConnected:Bool = false;
        private var internetConnected:Bool {
            get {
                return _internetConnected;
            }
            
            set {
                _internetConnected = newValue;
                self.internetConnectionLabelHidden = _internetConnected;
            }
        }
    
    fileprivate var _internetConnectionLabelHidden:Bool!;
        fileprivate var internetConnectionLabelHidden:Bool {
            
            set {
                if (_internetConnectionLabelHidden != newValue)
                {
                    _internetConnectionLabelHidden = newValue;
                    
                    var newFrame = self.internetConnectionLbl.frame;
                    
                    if (_internetConnectionLabelHidden == true) {
                        newFrame.origin.y = -(44 + self.statusBarFrameHeight);
                    } else {
                        newFrame.origin.y = 0;
                        
                        self.window?.bringSubviewToFront(self.internetConnectionLbl);
                    }
                    
                    UIView.animate(withDuration: 0.35, animations: { () -> Void in
                        self.internetConnectionLbl.frame = newFrame;
                    });
                }
            }
            
            get {
                return (_internetConnectionLabelHidden == nil) ?true:_internetConnectionLabelHidden;
            }
        } //P.E.
    
    private var statusBarFrameHeight: CGFloat {
     //   return self.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0;
        return UIApplication.shared.statusBarFrame.height
    }
    
    fileprivate var _internetConnectionLbl: UIButton!;
    fileprivate var internetConnectionLbl: UIButton {
        get {
            
            if (_internetConnectionLbl == nil) {
                let statusBarHeight:CGFloat = self.statusBarFrameHeight;
                let btnSize:CGSize = CGSize(width: UIScreen.main.bounds.width, height: 44 + statusBarHeight);
                
                _internetConnectionLbl = UIButton();
                _internetConnectionLbl.frame = CGRect(x: 0, y: -btnSize.height, width: btnSize.width, height: btnSize.height);
                
                _internetConnectionLbl.titleEdgeInsets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0);
                
                _internetConnectionLbl.setTitle("No Internet Connection", for: UIControl.State.normal);
                _internetConnectionLbl.setTitleColor(UIColor.white, for: UIControl.State.normal);
                
                _internetConnectionLbl.backgroundColor = UIColor.Theme.green;
                
                _internetConnectionLbl.titleLabel?.font = UIFont.Poppins(.medium, size: 14.0)
                
                //Adding Target
                _internetConnectionLbl.addTarget(self, action: #selector(self.internetConnectionLabelTapHandler(_:)) , for: .touchUpInside)
                
                self.window?.addSubview(_internetConnectionLbl);
            }
            
            return _internetConnectionLbl;
        }
    }
    
    @objc func internetConnectionLabelTapHandler(_ btn:AnyObject) {
        self.internetConnectionLabelHidden = true;
    }
    
}

