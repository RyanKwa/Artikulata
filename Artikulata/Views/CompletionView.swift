//
//  CompletionView.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 22/06/22.
//

import SwiftUI

struct CompletionView: View {
    @EnvironmentObject var appState: AppState
    @State var time = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack {
            Background(backgroundImage: "Completion")
                .onAppear() {
                    AudioPlayer.playAudio()
                }
                .onReceive(timer) { _ in
                    if time > 0 {
                        time -= 1
                    }
                    
                    if time == 0 {
                        appState.rootViewId = UUID()
                    }
                }
                .onDisappear() {
                    AudioPlayer.stopAudio()
                }
        }
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView()
    }
}
