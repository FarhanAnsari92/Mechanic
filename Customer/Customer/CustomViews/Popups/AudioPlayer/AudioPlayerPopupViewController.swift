//
//  AudioPlayerPopupViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 07/12/2021.
//

import UIKit

class AudioPlayerPopupViewController: BasePopupViewController {
    
    let recorder: HRAudioRecorder?
    
    @IBOutlet weak var lblRecordingDuration: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var audioPlayerView: UIView!
    @IBOutlet weak var submitButtonView: UIView!
    
    var audioPath: String?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        recorder = HRAudioRecorder.shared
        super.init(nibName: "AudioPlayerPopupViewController", bundle: nil)
    }
    
    func reset()  {
        updateCounter(duration: 0)
    }
    
    func updateCounter(duration: TimeInterval)  {
        if duration == 5 {
            recorder?.stop(completion: { [weak self] (path) in
//                self.delegate?.didStopRecording(url: URL(fileURLWithPath: path ?? ""))
                
                guard let self = self else { return }
                self.audioPlayerView.isHidden = false
                self.submitButtonView.isHidden = false
                print(path)
                self.audioPath = path
            })
        }
        DispatchQueue.main.async {
            self.lblRecordingDuration.text = Helper.stringFromTimeInterval(interval: duration) as String
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startRecording()
    }
    
    func startRecording() {
        reset()
        let fileName = NSUUID().uuidString
        let recordingPath = getDocumentsDirectory().appendingPathComponent(fileName.appending(".m4a"))
        
        recorder?.record(atPath: recordingPath.path)
        recorder?.progressUpdate(block: { (duration) in
            self.updateCounter(duration: Double(duration))
        })
        
        recorder?.completionBlock = { url in
            print("URL - ", url)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    @IBAction func onActionDone(_ sender: Any) {
        recorder?.stop(completion: { (url) in
            print(url)
        })
        self.dismissPopup()
    }
    
    @IBAction func playAudioButtonHandler(_ sender: UIButton) {
        if let path = self.audioPath {
            HRAudioPlayer.shared.play(url: URL(fileURLWithPath: path));
        }
    }
    
    @IBAction func submitButtonHandler(_ sender: UIButton) {
        print("Submit")
    }

}


extension AudioPlayerPopupViewController {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
