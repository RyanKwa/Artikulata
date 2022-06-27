//
//  ContentView.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 08/06/22.
//

import SwiftUI

struct ListWordView: View {
    @State var isActive: Bool = false
    @State var word: String = "Marah"
    @Environment(\.presentationMode) var presentation
    
    var categoriesName : WordCategories

    var body: some View {
        
        NavigationView {
            ZStack {
                switch categoriesName {
                    case .KataBenda:
                        Background(backgroundImage: "BG-kata-benda")
                    case .KataSifat:
                        Background(backgroundImage: "BG-kata-sifat")
                    case .KataKerja:
                        Background(backgroundImage: "BG-kata-kerja")
                }
                VStack{
                    
                    HStack {
                        
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
                        
                        Spacer()
                        
                        FontView(text: categoriesName.rawValue, size: 32)
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 100) {
                        if categoriesName == .KataSifat {
                            WordImageView(imageName: "Senang", imageText: "Senang", word: Words.Senang, wordCategory: categoriesName)
                            
                            WordImageView(imageName: "Marah", imageText: "Marah", word: Words.Marah, wordCategory: categoriesName)
                            
                            WordImageView(imageName: "Sedih", imageText: "Sedih", word: Words.Sedih, wordCategory: categoriesName)
                        }

                        else if categoriesName == .KataBenda{
                            WordImageView(imageName: "Baju", imageText: "Baju", word: Words.Baju, wordCategory: categoriesName)
                            
                            WordImageView(imageName: "Celana", imageText: "Celana", word: Words.Celana, wordCategory: categoriesName)
                            
                            WordImageView(imageName: "Bangku", imageText: "Bangku", word: Words.Bangku, wordCategory: categoriesName)
                        }
                        
                        else if categoriesName == .KataKerja{
                            WordImageView(imageName: "Tidur", imageText: "Tidur", word: Words.Tidur, wordCategory: categoriesName)
                            
                            WordImageView(imageName: "Makan", imageText: "Makan", word: Words.Makan, wordCategory: categoriesName)
                            
                            WordImageView(imageName: "Minum", imageText: "Minum", word: Words.Minum, wordCategory: categoriesName)
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListWordView(categoriesName: WordCategories.KataBenda)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
