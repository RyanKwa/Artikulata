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
    
    ///In case of user will immediately go to the next screen using @Published
//    var wowKamuHebatFinishedPlaying = false
//    @Published var wowKamuHebatTrigger = false

    var afterGiliranMu = false
    var audioPlayNow = false
    var recordNow = false
    var afterPlayingVideo = false
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayer.stop()
        audioPlayer.prepareToPlay()
        self.audioFinishPlaying = true
//        if wowKamuHebat {
//            //trigger wow kamu hebat
//        }
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
    
    func wowKamuHebatTurn(){
        ///Assumption: When the audio has ended, user need to wait 5 seconds
        ///
        wowKamuHebat()
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
            print("GILIRANMU")
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
            print("SEKali lagi")
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
    func wowKamuHebat(){
        let url = Bundle.main.url(forResource: "WowKamuHebat", withExtension: "m4a")
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
