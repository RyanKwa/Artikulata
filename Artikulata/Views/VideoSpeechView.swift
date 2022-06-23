//
//  VideoSpeechView.swift
//  Artikulata
//
//  Created by Minawati on 21/06/22.
//

import SwiftUI
import AVKit

struct VideoSpeechView: View {
    
    @State private var widthSize: CGFloat = UIScreen.main.bounds.size.width
    @State private var heightSize: CGFloat = UIScreen.main.bounds.size.height
    var word: String
    @State private var player: AVPlayer
    
    init(video: Video){
        self.word = video.rawValue
        self.player = AVPlayer(url: Bundle.main.url(forResource: video.rawValue, withExtension: "MOV")!)
    }
    
    var body: some View {
        
        ZStack {
            
            Color("yellow-pastel")
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                
                GeometryReader { geo in
                    AVPlayerControllerRepresented(player: player)
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .disabled(true)
                        .edgesIgnoringSafeArea(.all)
                        .onAppear() {
                            self.player.play()
                        }
                }
                .frame(width: (widthSize/2)+10)
                .edgesIgnoringSafeArea(.all)
                
                Spacer()
                
                VStack {
                    FontView(text: word, size: 64)
                    
                    // lottie animation
                }
                
                Spacer()
            }
            
            Button(action: {
                self.player.seek(to: .zero)
                self.player.play()
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
        }
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

enum Video: String, CaseIterable {
    case Kursi, Baju, Celana, Senang, Marah, Sedih, Makan, Minum, Tidur
}

struct VideoSpeechView_Previews: PreviewProvider {
    static var previews: some View {
        VideoSpeechView(video: Video.Marah)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
