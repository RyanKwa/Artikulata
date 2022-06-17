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
        VStack {
            
            // masih perlu ditambahin isPressed event
            // bisa dikasih animation(.spring())
            Button {
                print("button pressed") // action
            } label: {
                Image(imageName)
            }
            .buttonStyle(PlainButtonStyle())
            
            FontView(text: imageText, size: 26)
        }
    }
}

struct WordImageView_Previews: PreviewProvider {
    static var previews: some View {
        WordImageView(imageName: "test", imageText: "Test")
    }
}
