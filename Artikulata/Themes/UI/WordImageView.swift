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
    
    @State var isActive = false
    var word: Words
    var wordCategory: WordCategories
    
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
                .hidden()
            )
    }
}

struct WordImageView_Previews: PreviewProvider {
    static var previews: some View {
        WordImageView(imageName: "Senang", imageText: "Senang", word: Words.Senang, wordCategory: WordCategories.KataSifat)
    }
}
