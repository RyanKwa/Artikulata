//
//  AudioPlayerObserver.swift
//  Artikulata
//
//  Created by Evelin Evelin on 24/06/22.
//

import AVFoundation
import Foundation

class AudioPlayerObserver: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var audioPlayer = AVAudioPlayer()
    
    @Published var audioFinishPlaying = false
    @Published var audioTriggered = false
    @Published var recordTriggered = false
    var afterGiliranMu = false
    var audioPlayNow = false
    var recordNow = false
    var afterPlayingVideo = false
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.audioFinishPlaying = true
        
        if afterGiliranMu {
            afterGiliranMu = false
            recordNow = true
            self.recordTriggered = true
        }
        else{
            ///Play Video
            self.audioPlayNow = false
            self.audioTriggered = true
        }
    }
    
    func giliranMuAudio(){
        
        let url = Bundle.main.url(forResource: "Giliranmu", withExtension: "m4a")
        guard url != nil else {
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.play()
            audioPlayer.delegate = self
        }
        catch{
            print("ERROR: Audio not found")
        }
        
    }
    
    func sekaliLagiAudio(){
        
        let url = Bundle.main.url(forResource: "SekaliLagi", withExtension: "m4a")
        guard url != nil else {
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.play()
            audioPlayer.delegate = self
        }
        catch{
            print("ERROR: Audio not found")
        }
        
    }
    
    func yukCobaLagi(){
        let url = Bundle.main.url(forResource: "YukCobaLagi", withExtension: "m4a")
        guard url != nil else {
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.play()
            audioPlayer.delegate = self
        }
        catch{
            print("ERROR: Audio not found")
        }
    }
}
