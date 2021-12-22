//
//  AudioPlayerView.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 21/12/2021.
//

import UIKit

class AudioPlayerView: NibDesignable {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var btnAudioPlayer: UIButton!
    
    var removeAudioCompletion: (() -> Void)?
    
    var audioPath: String?
    var audioDuration: Double = 0.0
    
    func setupView() {
        self.slider.value = 0
        self.slider.minimumValue = 0
        self.slider.maximumValue = Float(self.audioDuration)
    }
    
    @IBAction func playAndStopButtonHandler(_ sender: UIButton) {
        
        if let path = self.audioPath {
            if !HRAudioPlayer.shared.isPlaying {
                HRAudioPlayer.shared.play(url: URL(fileURLWithPath: path));
                HRAudioPlayer.shared.seekProgressCompletion = { progress in
                    print("progress -- ", progress)
                    self.slider.value = progress ?? 0.0
                }
            } else {
                HRAudioPlayer.shared.pause()
            }
        }
    }
    
    func stopAudio() {
        HRAudioPlayer.shared.stop()
    }
    
    @IBAction func removeAudio(_ sender: UIButton) {
        self.stopAudio()
        removeAudioCompletion?()
    }

}
