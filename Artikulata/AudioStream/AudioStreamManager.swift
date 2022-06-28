//
//  AudioStreamManager.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 22/06/22.
//

import AVFoundation
import Foundation
import SoundAnalysis

class AudioStreamManager {
    //Audio
    private var audioEngine: AVAudioEngine?
    private var inputBus: AVAudioNodeBus?
    private var micInputFormat: AVAudioFormat?
    
    //Sound classifier
    private var soundAnalyzer: SNAudioStreamAnalyzer?
    private var soundClassifierRequest: SNClassifySoundRequest?
    private var wordCategory: WordCategories
    init(wordCategory: WordCategories){
        self.wordCategory = wordCategory
        audioEngine = AVAudioEngine()
        
        inputBus = AVAudioNodeBus(0)
        
        guard let inputBus = inputBus else {
            print("ERROR: Input bus unavailable")
            return
        }
        
        //ambil input node dari input bus
        micInputFormat = audioEngine?.inputNode.inputFormat(forBus: inputBus)
        
        guard let micInputFormat = micInputFormat else {
            print("ERROR: Mic input format unavailable")
            return
        }
        prepareAudioEngine()
        
        soundAnalyzer = SNAudioStreamAnalyzer(format: micInputFormat)
        
        prepareSoundClassifier()
    }
    private func prepareAudioEngine(){
        guard let audioEngine = audioEngine else {
            print("ERROR: AudioEngine Unavailable")
            return
        }
        do{
            try audioEngine.start()
        }
        catch{
            print("ERROR: \(error.localizedDescription)")
        }
    }
    private func prepareSoundClassifier(){
        let config = MLModelConfiguration()
        ///untuk sementara masih kata sifat
        if wordCategory == .KataBenda{
            print("USING KAta BENDa")
            let soundClassifier = try? KataBendaModel(configuration: config)
            
            guard let soundClassifier = soundClassifier else{
                print("ERROR: Model doesn't Exist")
                return
            }
            soundClassifierRequest = try? SNClassifySoundRequest(mlModel: soundClassifier.model)
        }
        else if wordCategory == .KataSifat{
            print("USING KAta SIFAT")
            let soundClassifier = try? KataSifatModel(configuration: config)
            
            guard let soundClassifier = soundClassifier else{
                print("ERROR: Model doesn't Exist")
                return
            }
            soundClassifierRequest = try? SNClassifySoundRequest(mlModel: soundClassifier.model)
        }
        else if wordCategory == .KataKerja{
            print("USING KAta KERJA")
            let soundClassifier = try? KataKerjaModel(configuration: config)
            
            guard let soundClassifier = soundClassifier else{
                print("ERROR: Model doesn't Exist")
                return
            }
            soundClassifierRequest = try? SNClassifySoundRequest(mlModel: soundClassifier.model)
        }
    }
    /**
     Use this function to start the live audio
     */
    func startLiveAudio(){
        guard let audioEngine = audioEngine else {
            print("ERROR: AudioEngine Unavailable")
            return
        }
        guard let inputBus = inputBus else {
            print("ERROR: Input bus unavailable")
            return
        }
        guard let micInputFormat = micInputFormat else {
            print("ERROR: Mic input format unavailable")
            return
        }
        audioEngine.inputNode.removeTap(onBus: inputBus)
        audioEngine.inputNode.installTap(onBus: inputBus, bufferSize: 1024, format: micInputFormat) {
            [unowned self] (buffer, time) in
            DispatchQueue.global(qos: .userInitiated).async {
                self.soundAnalyzer?.analyze(buffer, atAudioFramePosition: time.sampleTime)
            }
        }
    }
    /**
     Use this function to stop the live audio
     */
    func stopLiveAudio(){
        guard let audioEngine = audioEngine else {
            print("ERROR: AudioEngine Unavailable")
            return
        }
        guard let inputBus = inputBus else {
            print("ERROR: Input bus unavailable")
            return
        }
        audioEngine.inputNode.removeTap(onBus: inputBus)
    }
    
    func addResultObservation(with observer: SNResultsObserving) {
        
        guard let soundClassifierRequest = soundClassifierRequest else {
            print("ERROR: Sound Classification Request unavailable")
            return
        }
        guard let soundAnalyzer = soundAnalyzer else {
            print("ERROR: Sound Analyzer unavailable")
            return
        }
        
        do {
            try soundAnalyzer.add(soundClassifierRequest, withObserver: observer)
        }
        catch {
            print("ERROR: observer for the sound classification results: \(error.localizedDescription)")
        }
        
    }
}
