//
//  VideoSpeechView.swift
//  Artikulata
//
//  Created by Minawati on 21/06/22.
//

import SwiftUI
import AVKit
import Lottie


struct VideoSpeechView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var soundAnalyzerObserver: SoundAnalyzerObserver
    @ObservedObject var videoStatusObserver = VideoStatusObserver()
    @ObservedObject var audioObserver = AudioPlayerObserver()
    
    @State private var widthSize: CGFloat = UIScreen.main.bounds.size.width
    @State private var heightSize: CGFloat = UIScreen.main.bounds.size.height
    
    @State var videoIsPlaying = true
    @State var timeToPlayAudio = false
    @State var isRecording = false
    @State var recordCycleFinished = false
    @State var duration = 0
    @State var numberOfTries = 0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var videoPlayer: AVPlayer
    var currentWordDisplay: String
    private var audioManager: AudioStreamManager
    
    init(video: Words, wordCategory: WordCategories){
        self.currentWordDisplay = video.rawValue
        self.videoPlayer = AVPlayer(url: Bundle.main.url(forResource: video.rawValue, withExtension: "MOV")!)
        self.videoStatusObserver = VideoStatusObserver()

        self.soundAnalyzerObserver = SoundAnalyzerObserver(currentWord: video.rawValue)
        self.audioManager = AudioStreamManager(wordCategory: wordCategory)
        audioManager.addResultObservation(with: soundAnalyzerObserver)
    }
    
    var body: some View {
        
        ZStack {
            
            Color.yellowPastel
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                
                GeometryReader { geo in
                    AVPlayerControllerRepresented(player: videoPlayer)
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .disabled(true)
                        .edgesIgnoringSafeArea(.all)
///                         trigger B video untuk play
                        .onReceive(videoStatusObserver.$videoTriggered, perform: { _ in
                            let videoWillPlay = videoStatusObserver.willStartPlaying ? true : false
                            guard soundAnalyzerObserver.navigateToNextView == false else {
                                return
                            }
                            guard videoWillPlay == true else{
                                audioObserver.afterPlayingVideo = true
                                audioObserver.audioPlayNow = true
                                audioObserver.audioTriggered = true
                                return
                            }
                            
                            resetVideo()
                            resetRecordingStatus()
                            NotificationCenter.default.addObserver(videoStatusObserver, selector: #selector(videoStatusObserver.playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
                        })
                }
                .frame(width: (widthSize/2)+10)
                .edgesIgnoringSafeArea(.all)
                Spacer()
                
                VStack {
                    FontView(text: currentWordDisplay, size: 64)
                        .offset(x: 0, y: 35)
///                         trigger A:  audio  play
                        .onReceive(audioObserver.$audioTriggered) { _ in
                            timeToPlayAudio = audioObserver.audioPlayNow ? true : false
                            guard timeToPlayAudio == true else {
                                videoStatusObserver.willStartPlaying = true
                                videoStatusObserver.videoTriggered = true
                                audioObserver.audioPlayNow = false
                                return
                            }
                            guard soundAnalyzerObserver.navigateToNextView == false else {
                                return
                            }
                            self.recordCycleFinished = false
                            if numberOfTries == 0 || audioObserver.afterPlayingVideo {
                                audioObserver.afterPlayingVideo = false
                                audioObserver.afterGiliranMu = true
                                audioObserver.audioPlayNow = false
                                audioObserver.giliranMuAudio()
                                return
                            }
                            if numberOfTries == 1 {
                                audioObserver.afterPlayingVideo = true
                                audioObserver.audioPlayNow = false
                                videoStatusObserver.willStartPlaying = true
                                audioObserver.yukCobaLagi()

                            }
                            else if numberOfTries == 2 {
                                audioObserver.afterPlayingVideo = true
                                audioObserver.audioPlayNow = false
                                videoStatusObserver.willStartPlaying = true
                                audioObserver.sekaliLagiAudio()
                            }
                        }
        
                    
                    if readyToRecord() {

                        LottieAnimationView(isPaused: true)
                            .edgesIgnoringSafeArea(.all)
                            .offset(x: -25, y: heightSize/30-18)
                            .opacity(0.2)

///                             trigger C:  speech  start
                            .onReceive(audioObserver.$recordTriggered) { _ in
                                let recordNow = audioObserver.recordNow ? false : true
                                guard recordNow == false else{
                                    return
                                }
                                videoIsPlaying = false
                                audioManager.startLiveAudio()
                                self.isRecording = true
                            }
                    }
                    else{
                        LottieAnimationView(isPaused: false)
                            .edgesIgnoringSafeArea(.all)
                            .offset(x: -25, y: heightSize/30-18)
                            .opacity(1)
                            .onReceive(timer) { _ in
                                guard isRecording == true else{
                                    return
                                }
                                //1 cycle = wrong = +1 Number Of Tries
                                if duration == Constant.MAX_DURATION{
                                    audioManager.stopLiveAudio()
                                    stopTimer()
                                    self.recordCycleFinished = true
                                    self.isRecording = false
                                    self.numberOfTries += 1
                                    if numberOfTries == Constant.MAX_TRIES {
                                        stopTimer()
                                        soundAnalyzerObserver.navigateToNextView = true
                                    }
                                    else{
                                        audioObserver.recordNow = false
                                        videoIsPlaying = true
                                        self.audioObserver.audioPlayNow = true
                                        self.audioObserver.afterPlayingVideo = false
                                        self.audioObserver.audioTriggered = true
                                    }
                                }

                                else if duration <= Constant.MAX_DURATION {
                                    duration += 1
                                }
///                                  Move to the completion page
                                if soundAnalyzerObserver.navigateToNextView {
                                    audioManager.stopLiveAudio()
                                    stopTimer()
                                }
                            }.background{
                                NavigationLink(destination: CompletionView().environmentObject(soundAnalyzerObserver).environmentObject(audioObserver).navigationBarHidden(true),isActive: $soundAnalyzerObserver.navigateToNextView){
                                }
                            }
                    }
                }
                
                Spacer()
            }
            
            // custom back button
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }){
                IconButton(iconName: "chevron.backward")
            }
            .buttonStyle(PlainButtonStyle())
            .position(x: widthSize/50, y: heightSize/6)
            
            // replay button
            Button(action: {
                replayVideo()
            }){
                IconButton(iconName: "gobackward")
            }
            .buttonStyle(PlainButtonStyle())
            .position(x: widthSize/4-30, y: heightSize/2-20)
            .isHidden(videoIsPlaying)
        }.onDisappear{
            if !soundAnalyzerObserver.navigateToNextView{
                stopTimer()
                audioObserver.audioPlayer.stop()
                self.videoPlayer.pause()
                self.videoPlayer.seek(to: .zero)
            }
        }
    }
    func startTimer(){
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    func stopTimer(){
        self.timer.upstream.connect().cancel()
    }
    func readyToRecord() -> Bool{
        return !isRecording && !recordCycleFinished && numberOfTries != Constant.MAX_TRIES
    }
    func resetVideo() {
        /// possible solution untuk fix speaker 
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print("AVAudioSession error: \(error.localizedDescription)")
        }
        self.videoPlayer.seek(to: .zero)
        self.videoPlayer.play()
    }
    func replayVideo(){
        audioObserver.recordNow = false
        audioObserver.afterPlayingVideo = true
        resetVideo()
        stopTimer()
        resetRecordingStatus()
        audioManager.stopLiveAudio()
        videoIsPlaying = true
    }
    func resetRecordingStatus(){
        self.isRecording = false
        self.duration = 0
        self.recordCycleFinished = false
    }
}

struct AVPlayerControllerRepresented: UIViewControllerRepresentable {
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

struct VideoSpeechView_Previews: PreviewProvider {
    static var previews: some View {
        VideoSpeechView(video: Words.Marah, wordCategory: WordCategories.KataSifat)
            .previewInterfaceOrientation(.landscapeRight)
    }
}

