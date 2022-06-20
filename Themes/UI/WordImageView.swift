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
    
    var body: some View {
            // masih perlu ditambahin isPressed event
            // bisa dikasih animation(.spring())
            Button {
                print("button pressed") // action
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
    }
}

struct WordImageView_Previews: PreviewProvider {
    static var previews: some View {
        WordImageView(imageName: "Senang", imageText: "Senang")
    }
}
