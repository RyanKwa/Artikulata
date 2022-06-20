//
//  ContentView.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 08/06/22.
//

import SwiftUI

struct ListWordView: View {
    var body: some View {
        
        ZStack {
            
            Image("BG-kata-sifat")
                .resizable()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                
                HStack {
                    
                    BackButtonView()
                    
                    Spacer()
                    
                    FontView(text: "Kata Sifat", size: 32)
                        .frame(width: 210, height: 0, alignment: .leading)
                    
                    Spacer()
                }
                
                HStack(spacing: 100) {
                    WordImageView(imageName: "Senang", imageText: "Senang")
                    WordImageView(imageName: "Marah", imageText: "Marah")
                    WordImageView(imageName: "Sedih", imageText: "Sedih")
                }
                .padding(.top, 40)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListWordView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.landscapeRight)
    }
}
