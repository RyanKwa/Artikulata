//
//  ListCategories.swift
//  Artikulata
//
//  Created by Shaqina Yasmin on 22/06/22.
//


import SwiftUI
import AVFoundation

struct ListCategories: View {
    
    var audioPermission = AudioPermission()
    
    var body: some View {
        //background color
        NavigationView {
            
            ZStack {
                Color.yellowPastel
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    //title
                    Text("Mau belajar apa hari ini?")
                        .font(Font.custom("FredokaOne-Regular", size: 32))
                        .multilineTextAlignment(.center)
                        
                    Spacer()
                        .frame(height: 35)
                    
                    //buttons of categories
                    HStack(alignment: .top, spacing: 27){
                        CategoriesButton(categoriesImage: "Kata-benda", categoriesName: WordCategories.KataBenda)
                        CategoriesButton(categoriesImage: "Kata-sifat", categoriesName: WordCategories.KataSifat)
                        CategoriesButton(categoriesImage: "Kata-kerja", categoriesName: WordCategories.KataKerja)
                    }
                    .padding(.top, 10)
                }
                .padding(.bottom, 30)
            }
        }.onAppear(){
            audioPermission.requestPermission()
        }
    }
}

struct ListCategories_Previews: PreviewProvider {
    static var previews: some View {
        ListCategories()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}



