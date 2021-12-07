//
//  AudioPlayerPopupViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 07/12/2021.
//

import UIKit

class AudioPlayerPopupViewController: BasePopupViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "AudioPlayerPopupViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    @IBAction func onActionDone(_ sender: Any) {
        
        self.dismissPopup()
    }

}
