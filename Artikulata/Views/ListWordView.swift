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
                
//                if (categoriesName == "Kata Benda") {
//                    Background(backgroundImage: "BG-kata-benda")}
//                else if (categoriesName == "Kata Sifat"){
//                    Background(backgroundImage: "BG-kata-sifat")
//                }
//                else if (categoriesName == "Kata Kerja"){
//                    Background(backgroundImage: "BG-kata-kerja")}
                
                VStack{
                    
                    HStack {
                        
                        BackButtonView()
                        
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
                .padding(.bottom, 60)
            }
        }
    }
}

//Hello wkwkwkkwkw


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListWordView(categoriesName: WordCategories.KataBenda)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

struct Background : View {
    var backgroundImage : String = "BG-kata-sifat"
    
    var body: some View {
        Image(backgroundImage)
            .resizable()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}



