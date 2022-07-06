//
//  CompletionView.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 22/06/22.
//

import SwiftUI

struct CompletionView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var soundAnalyzerObserver: SoundAnalyzerObserver
    @EnvironmentObject var audioObserver: AudioPlayerObserver
    
    @State var time = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        
        VStack {
            Background(backgroundImage: "Completion")
                .onAppear() {
                    audioObserver.wowKamuHebatTurn()
                }
                .onReceive(timer) { _ in
                    print("TIME: \(time)")
                    if time == 0 {
                        self.timer.upstream.connect().cancel()
                        audioObserver.audioPlayer.stop()
                        self.appState.moveToListWord = true
                        if soundAnalyzerObserver.navigateToNextView {
                            soundAnalyzerObserver.navigateToNextView = false
                        }
                    }
                    else if time > 0 {
                        time -= 1
                    }
                    
                }
        }
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView()
    }
}
