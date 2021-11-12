//
//  BaseStepper.swift
//  CalandarDemo
//
//  Created by BYKEA - Muhammad Ahsan Iqbal on 19/06/2018.
//  Copyright © 2018 Google. All rights reserved.
//

import UIKit

protocol BaseStepperDelegate: NSObjectProtocol {
    func stepperValueChnaged(_ sender: BaseStepper, isIncremented: Bool)
}

class BaseStepper: UIView {
    
    var value: Int = 0 {
        didSet {
            self.lblCounter.fadeTransition(0.1)
            self.lblCounter.text = String(describing: self.value)
        }
    }
    
    weak var delegate: BaseStepperDelegate?
    @IBInspectable var maxValue: Int = 5;
    @IBInspectable var minValue: Int = 0 {
        didSet {
            self.value = self.minValue
        }
    }
    
    @IBOutlet weak var lblCounter: PaddingLabel!
    @IBOutlet weak var btnIncrement: UIButton!
    @IBOutlet weak var btnDecrement: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var parentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("BaseStepper", owner: self, options: nil)
        addSubview(self.contentView)        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.lblCounter.layer.cornerRadius = 5
        self.lblCounter.layer.masksToBounds = true
    }
    
    @IBAction func incrementHandler(_ sender: UIButton) {
        if self.value < maxValue {
            self.value += 1
            self.delegate?.stepperValueChnaged(self,isIncremented: true)
        }
    }
    
    @IBAction func decrementHandler(_ sender: UIButton) {
        if self.value > minValue {
            self.value -= 1
            self.delegate?.stepperValueChnaged(self,isIncremented: false)
        }
    }

}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
