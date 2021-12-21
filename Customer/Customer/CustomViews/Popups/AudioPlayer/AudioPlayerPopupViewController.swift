//
//  AudioPlayerPopupViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 07/12/2021.
//

import UIKit

protocol AudioPlayerPopupViewControllerDelegate: NSObjectProtocol {
    func didRecordAudio(path: String?, url: URL?)
}

class AudioPlayerPopupViewController: BasePopupViewController {
    
    let recorder: HRAudioRecorder?
    
    @IBOutlet weak var lblRecordingDuration: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var audioPlayerView: UIView!
    @IBOutlet weak var submitButtonView: UIView!
    @IBOutlet weak var btnRecorder: UIButton!
    
    var audioDuration: Double = 0.0
    
    weak var delegate: AudioPlayerPopupViewControllerDelegate?
    
    var audioPath: String?
    var audioURL: URL?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        recorder = HRAudioRecorder.shared
        super.init(nibName: "AudioPlayerPopupViewController", bundle: nil)
    }
    
    func reset()  {
        self.audioDuration = 0
        updateCounter(duration: 0)
    }
    
    func updateCounter(duration: TimeInterval)  {
        if duration == 10 {
            self.stopRecording()
        }
        DispatchQueue.main.async {
            self.lblRecordingDuration.text = Helper.stringFromTimeInterval(interval: duration) as String
        }
    }
    
    func stopRecording() {
        self.btnRecorder.setImage(UIImage(named: "ic_mic"), for: .normal)
        recorder?.stop(completion: { [weak self] (path, url) in
            
            guard let self = self else { return }
            self.audioPlayerView.isHidden = false
            self.submitButtonView.isHidden = false
            print(path)
            self.slider.minimumValue = 0
            self.slider.maximumValue = Float(self.audioDuration)
            self.audioPath = path
            self.audioURL = url
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        startRecording()
    }
    
    func startRecording() {
        self.btnRecorder.setImage(UIImage(named: "ic_stop_recording"), for: .normal)
        reset()
        let fileName = NSUUID().uuidString
        let recordingPath = getDocumentsDirectory().appendingPathComponent(fileName.appending(".m4a"))
        
        recorder?.record(atPath: recordingPath.path)
        recorder?.progressUpdate(block: { [weak self] duration in
            self?.audioDuration = Double(duration)
            self?.updateCounter(duration: Double(duration))
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    @IBAction func onActionDone(_ sender: Any) {
        if recorder?.state == .recording || recorder?.state == .paused {
            print("audio was being record")
            recorder?.stop(completion: { [weak self] (path, url) in
                print("Dismiss by user - ", path)
                print("Dismiss by user - ", url)
                self?.delegate?.didRecordAudio(path: nil, url: nil)
                self?.dismissPopup()
            })
        } else {
            print("audio has been being record")
            self.delegate?.didRecordAudio(path: nil, url: nil)
            self.dismissPopup()
        }

        
    }
    
    @IBAction func recordAudioActionButtonHandler(_ sender: UIButton) {
        if recorder?.state == .stop {
            self.startRecording()
        } else if recorder?.state == .recording {
            self.stopRecording()
        }
    }
    
    @IBAction func playAudioButtonHandler(_ sender: UIButton) {
        if let path = self.audioPath {
            HRAudioPlayer.shared.play(url: URL(fileURLWithPath: path));
            HRAudioPlayer.shared.seekProgressCompletion = { progress in
                print("progress -- ", progress)
                self.slider.value = progress ?? 0.0
            }
        }
    }
    
    @IBAction func submitButtonHandler(_ sender: UIButton) {
        print("============")
        print(recorder?.state)
        print(recorder?.state.rawValue)
        print("============")
        
        self.delegate?.didRecordAudio(path: self.audioPath, url: self.audioURL)
        self.dismissPopup()
        
    }

}


extension AudioPlayerPopupViewController {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
