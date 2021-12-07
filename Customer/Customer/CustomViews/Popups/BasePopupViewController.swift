//
//  BasePopupViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 07/12/2021.
//

import UIKit

class BasePopupViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .overCurrentContext
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismissPopup()  {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BasePopupViewController {
    
    private func setupView()  {
        
        self.containerView.layer.cornerRadius = 8
        self.containerView.clipsToBounds = true
        
        self.view.tag = 1000
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onHandleTap(gesture:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func onHandleTap(gesture: UITapGestureRecognizer) {
        self.dismissPopup()
    }
}

extension BasePopupViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard let v = touch.view else { return false }
        
        return v == self.view && v.tag == 1000
    }
}

extension BasePopupViewController {
    
    class func audioPlayerPopup() -> AudioPlayerPopupViewController {
        let controller = AudioPlayerPopupViewController(nibName: "AudioPlayerPopupViewController", bundle: nil)
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return controller
    }
    
}
