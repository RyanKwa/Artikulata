//
//  AudioPlayer.swift
//  Artikulata
//
//  Created by Minawati on 28/06/22.
//

import Foundation
import AVFoundation

class AudioPlayer {
    
    static var audioPlayer: AVAudioPlayer?
    
    static func playAudio() {
        let url = Bundle.main.url(forResource: "WowKamuHebat", withExtension: "m4a")
        
        guard url != nil else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer?.play()
        } catch {
            print("Error: Audio not found")
        }
    }
    
    static func stopAudio() {
        audioPlayer?.pause()
    }
}
