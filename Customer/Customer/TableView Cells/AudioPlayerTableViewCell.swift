//
//  AudioPlayerTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/12/2021.
//

import UIKit

class AudioPlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var audioView: AudioPlayerView!
    var removeAudioCompletion: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        audioView.removeAudioCompletion = { [weak self] in
            self?.removeAudioCompletion?()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(audio: Audio) {
        self.audioView.audioPath = audio.path
        if let duration = audio.duration {
            self.audioView.audioDuration = duration
        }
        self.audioView.setupView()
    }
    
}
