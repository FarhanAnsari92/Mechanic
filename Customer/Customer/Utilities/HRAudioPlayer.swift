//
//  HRAudioPlayer.swift
//  bykea order screen
//
//  Created by Arsal Imam on 17/07/2021.
//

import Foundation
import AVFoundation

protocol Player {
    func play(url: URL)
    func pause()
    func stop()
    func seekTo(time: TimeInterval)
}

final class HRAudioPlayer: NSObject, Player {
    
    static let shared = HRAudioPlayer()
    
    private var audioSession : AVAudioSession = AVAudioSession.sharedInstance()
    private var audioPlayer : AVAudioPlayer = AVAudioPlayer()
    var seekProgressCompletion: ((Float?) -> Void)?
    var isPlaying : Bool = false
    
    var rate : Float?{
        didSet{
            print("Rate - ", rate)
            if (rate! < 0.5) {
                rate = 0.5
            } else if (rate! > 2.0) {
                rate = 2.0
            }
        }
    }
    
    var timer: Timer?
    var timerValue: Float = 0
    
    func play(url: URL)  {
        if !isPlaying {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                timerValue = 0
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
                (rate == nil) ? (audioPlayer.enableRate = false) : (audioPlayer.enableRate = true)
                audioPlayer.rate = rate ?? 1.0
                audioPlayer.delegate = self
                audioPlayer.play()
                isPlaying = true
            } catch _ {
                print("no file exists")
            }
        }
    }
    
    @objc func updateSlider() {
        //            print("interval - ", interval)
        timerValue += 0.01
        seekProgressCompletion?(timerValue)
        //            let time = Helper.stringFromTimeInterval(interval: interval)
        //            print("time - ", time)
        
    }
    
    func pause()  {
        if isPlaying {
            isPlaying = false
            timer?.invalidate()
            audioPlayer.pause()
        }
    }
    
    func stop()  {
        if isPlaying {
            isPlaying = false
            timer?.invalidate()
            audioPlayer.stop()
        }
    }
    
    func seekTo(time: TimeInterval) {
        audioPlayer.currentTime = time
    }
}


extension HRAudioPlayer: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        timer?.invalidate()
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        isPlaying = false
    }
}
