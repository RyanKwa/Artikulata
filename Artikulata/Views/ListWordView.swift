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
    
    var categoriesName : String

    var body: some View {
        
        NavigationView {
            ZStack {
                
                if (categoriesName == "Kata Benda") {
                    Background(backgroundImage: "BG-kata-benda")}
                else if (categoriesName == "Kata Sifat"){
                    Background(backgroundImage: "BG-kata-sifat")
                }
                else if (categoriesName == "Kata Kerja"){
                    Background(backgroundImage: "BG-kata-kerja")}


                
                VStack{
                    
                    HStack {
                        
                        BackButtonView()
                        
                        Spacer()
                        
                        FontView(text: categoriesName, size: 32)
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 100) {
                        if categoriesName == "Kata Sifat"{
                            WordImageView(imageName: "Senang", imageText: "Senang", word: Words.Senang)
                            
                            WordImageView(imageName: "Marah", imageText: "Marah", word: Words.Marah)
                            
                            WordImageView(imageName: "Sedih", imageText: "Sedih", word: Words.Sedih)}
                        
                        else if categoriesName == "Kata Benda"{
                            WordImageView(imageName: "Baju", imageText: "Baju", word: Words.Baju)
                            
                            WordImageView(imageName: "Celana", imageText: "Celana", word: Words.Celana)
                            
                            WordImageView(imageName: "Kursi", imageText: "Kursi", word: Words.Kursi)}

                        
                        else if categoriesName == "Kata Kerja"{
                            WordImageView(imageName: "Tidur", imageText: "Tidur", word: Words.Tidur)
                            
                            WordImageView(imageName: "Makan", imageText: "Makan", word: Words.Makan)
                            
                            WordImageView(imageName: "Minum", imageText: "Minum", word: Words.Minum)
                            
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
        ListWordView(categoriesName: "Kata Benda")
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



