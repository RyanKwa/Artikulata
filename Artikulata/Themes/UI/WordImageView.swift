//
//  WordImageView.swift
//  Artikulata
//
//  Created by Minawati on 14/06/22.
//

import SwiftUI

struct WordImageView: View {
    
    let imageName: String
    let imageText: String
    
    var word: Words
    var wordCategory: WordCategories
    @EnvironmentObject var appState: AppState
    
    @State var isActive = false
    var body: some View {
        Button {
            self.isActive = true

        } label: {
            VStack{
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .center)
                FontView(text: imageText, size: 26)
            }
            
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            NavigationLink(destination: VideoSpeechView(video: word, wordCategory: wordCategory).navigationBarTitle("").navigationBarHidden(true), isActive: $isActive) {

            }
            .isDetailLink(false)
            .hidden()
        )
        .onReceive(appState.$moveToListWord) { moveToListWord in
            if moveToListWord {
                isActive = false
                appState.moveToListWord = false
            }
        }
    }
}

struct WordImageView_Previews: PreviewProvider {
    static var previews: some View {
        WordImageView(imageName: "Senang", imageText: "Senang", word: Words.Senang, wordCategory: WordCategories.KataSifat)
    }
}
