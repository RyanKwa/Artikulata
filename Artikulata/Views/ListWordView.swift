//
//  ContentView.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 08/06/22.
//

import SwiftUI

struct ListWordView: View {

    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var appState: AppState
    var modulKategori: KategoriModel
    
    var body: some View {
        
        NavigationView {
            ZStack {
                switch modulKategori.kategoriKata {
                case .KataBenda:
                    Background(backgroundImage: "BG-kata-benda")
                case .KataSifat:
                    Background(backgroundImage: "BG-kata-sifat")
                case .KataKerja:
                    Background(backgroundImage: "BG-kata-kerja")
                default:
                    Background(backgroundImage: "")
                    
                }
                VStack{
                    
                    HStack {
                        
                        // custom back button
                        Button(action: {
                            self.presentation.wrappedValue.dismiss()
                        }){
                            IconButton(iconName: "chevron.backward")
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                        
                        FontView(text: modulKategori.kategoriKata?.rawValue ?? " ", size: 32)
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 100) {
                        let katas = modulKategori.kataDalamKategori
                        ForEach(katas!, id: \.self){ kata in
                            if let imageName = kata.imageName, let imageText = kata.imageText, let choosenWord = kata.word, let wordCategory = kata.wordCategory{
                                WordImageView(imageName: imageName, imageText: imageText, word: choosenWord, wordCategory: wordCategory)

                            }
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.bottom, 30)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListWordView(modulKategori: KategoriModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
