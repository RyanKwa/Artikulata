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
    @State var isActive = false
    var modulKategori = KategoriModel()
    var body: some View {
        //background color
        NavigationView {
            
            ZStack {
                Color.yellowPastel
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    //title
                    FontView(text: "Mau belajar apa hari ini?", size: 32)
                        .multilineTextAlignment(.center)
                        
                    Spacer()
                        .frame(height: 35)
                    
                    //buttons of categories
                    HStack(alignment: .top, spacing: 27){
                        let categories = modulKategori.populateModulKategori()
                        ForEach(categories, id: \.self) { category in
                            CategoriesButton(modulKategori: category)
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(.bottom, 30)
            }.onAppear(){
                audioPermission.requestPermission()
            }

        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ListCategories_Previews: PreviewProvider {
    static var previews: some View {
        ListCategories()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}



