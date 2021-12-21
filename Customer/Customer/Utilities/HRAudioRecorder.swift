
import Foundation
import AVFoundation

@objc enum RecordingState: Int {
    case paused = 0
    case recording = 1
    case stop = 2
}


@objc protocol Recorder {
    var state: RecordingState { get set }
    func record(atPath path: String)
    func pause()
    func resume()
    func stop(completion: @escaping (String?, URL?) -> ())
    @objc optional func progressUpdate(block: @escaping (CGFloat) -> Void)
}

final class HRAudioRecorder: NSObject, Recorder
{
    static let shared = HRAudioRecorder()
    
    fileprivate var timer: Timer!
    private var audioSession : AVAudioSession = AVAudioSession.sharedInstance()
    var audioRecorder : AVAudioRecorder!
    private var settings =   [  AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                                AVSampleRateKey: 12000,
                                AVNumberOfChannelsKey: 1,
                                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue ]
    
    var state: RecordingState = .stop
    var duration = CGFloat()
    
    private var filePath: String?
    var completionBlock: ((String?, URL?) -> ())?
    private var durationBlock: ((CGFloat) -> Void)?
    
    private func setup(ForPath path: String) {
        do{ /// Setup audio player
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
            audioRecorder = try AVAudioRecorder(url: URL(fileURLWithPath: path), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
        } catch let audioError as NSError {
            print ("Error setting up: %@", audioError)
        }
    }
    
    func record(atPath path: String) {
        
        self.filePath = path
        self.setup(ForPath: path)
        
        if state == .stop {
            do{
                try audioSession.setActive(true)
                duration = 0
                state = .recording
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateDuration), userInfo: nil, repeats: true) /// start  timer
                audioRecorder.record() /// start recording
                debugLog("started")
            } catch let recordingError as NSError{
                print ("Error recording : %@", recordingError.localizedDescription)
            }
        }
    }
    
    func resume() {
        if let recorder = audioRecorder {
            state = .recording
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateDuration), userInfo: nil, repeats: true)
            recorder.record()
        }
    }
    
    func pause() {
        if let recorder = audioRecorder {
            state = .paused
            recorder.pause()
            timer.invalidate()
        }
    }
    
    func stop(completion: @escaping (String?, URL?) -> ()) {
        completionBlock = completion
        if let recorder = audioRecorder {
            recorder.stop()
            audioRecorder = nil
            do {
                try audioSession.setActive(false)
                state = .stop
                debugLog("Recording Stopped")
            } catch {
                print("stop()",error.localizedDescription)
            }
        }
    }
    
    @objc func updateDuration() {
        if duration >= 60 {
            completionBlock?(self.filePath, self.audioRecorder.url)
            timer.invalidate()
            state = .stop
            return
        }
        if state == .recording {
            duration += 1
            self.durationBlock?(duration)
        }else{
            timer.invalidate()
        }
    }
    
    func progressUpdate(block: @escaping (CGFloat) -> Void) {
        self.durationBlock = block
    }
}

extension HRAudioRecorder: AVAudioRecorderDelegate
{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        completionBlock?(self.filePath, recorder.url)
        timer.invalidate()
        state = .stop
        debugPrint("recording \(flag ? "done" : "failed")")
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        completionBlock?(nil, nil)
        state = .stop
        timer.invalidate()
        debugPrint("error")
    }
}

//MARK:- Easy debugging
public func debugLog(_ message: String) {
    #if DEBUG
    debugPrint("=================================================")
    debugPrint(message)
    debugPrint("=================================================")
    #endif
}
