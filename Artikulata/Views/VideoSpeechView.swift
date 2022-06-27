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
    @ObservedObject var videoStatusObserver: VideoStatusObserver
    
    @State private var widthSize: CGFloat = UIScreen.main.bounds.size.width
    @State private var heightSize: CGFloat = UIScreen.main.bounds.size.height
    @State var isActive: Bool = false
    
    @State var isRecording = false
    @State var recordCycleFinished = false
    @State var duration = 0
    @State var numberOfTries = 0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var videoPlayer: AVPlayer
    var currentWordDisplay: String
    private var audioManager: AudioStreamManager
    
    init(video: Words){
        self.currentWordDisplay = video.rawValue
        self.videoPlayer = AVPlayer(url: Bundle.main.url(forResource: video.rawValue, withExtension: "MOV")!)
        
        self.videoStatusObserver = VideoStatusObserver()
        self.soundAnalyzerObserver = SoundAnalyzerObserver(currentWord: video.rawValue)
        self.audioManager = AudioStreamManager()
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
                        .onReceive(videoStatusObserver.$willStartPlaying, perform: { _ in
                            replayVideo()
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

                    /// masih sementara
                    if readyToRecord() {

                        LottieAnimationView(isPaused: true)
                            .edgesIgnoringSafeArea(.all)
                            .offset(x: -25, y: heightSize/30-18)
                            .opacity(0.2)
                            .onReceive(videoStatusObserver.objectWillChange) { _ in
                                guard isRecording == false else{
                                    return
                                }
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
                                
                                //1 cycle = wrong = +1 noofTries
                                //go watch the video
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
                                        self.videoStatusObserver.videoIsPlaying = true
                                        self.videoStatusObserver.willStartPlaying = true
                                    }
                                }

                                else if duration <= Constant.MAX_DURATION {
                                    duration += 1
                                }

                                /// kalau benar pindah
                                if soundAnalyzerObserver.navigateToNextView {
                                    audioManager.stopLiveAudio()
                                    stopTimer()
                                }

                                if numberOfTries == Constant.MAX_TRIES {
                                    audioManager.stopLiveAudio()
                                    stopTimer()
                                }

                            }
                            .background{

                                NavigationLink(destination: CompletionView().navigationBarHidden(true),isActive: $soundAnalyzerObserver.navigateToNextView){

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
                Circle()
                    .fill(Color(red: 0.58, green: 0.45, blue: 0.49))
                    .frame(width: 50, height: 50, alignment: .center)
                    .overlay(
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 28, alignment: .leading)
                            .foregroundColor(.white)
                    )
            }
            .buttonStyle(PlainButtonStyle())
            .position(x: widthSize/50, y: heightSize/6)
            .onDisappear(){
                self.videoPlayer.pause()
                self.videoPlayer.seek(to: .zero)
                stopTimer()
            }
            
            // replay button
            Button(action: {
                replayVideo()
                stopTimer()
                resetRecordingStatus()
                audioManager.stopLiveAudio()
                startTimer()
                videoStatusObserver.videoIsPlaying = true
            }){
                Circle()
                    .fill(Color(red: 0.58, green: 0.45, blue: 0.49))
                    .frame(width: 50, height: 50, alignment: .center)
                    .overlay(
                        Image(systemName: "gobackward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 28, alignment: .center)
                            .foregroundColor(.white)
                    )
            }
            .buttonStyle(PlainButtonStyle())
            .position(x: widthSize/4-30, y: heightSize/2-20)
            .isHidden(videoStatusObserver.videoIsPlaying)
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
    func replayVideo() {
        self.videoPlayer.seek(to: .zero)
        self.videoPlayer.play()
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
        VideoSpeechView(video: Words.Marah)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
