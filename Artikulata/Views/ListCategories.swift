//
//  ListCategories.swift
//  Artikulata
//
//  Created by Shaqina Yasmin on 22/06/22.
//


import SwiftUI

struct ListCategories: View {
    
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
                        CategoriesButton(categoriesImage: "Kata-benda", categoriesName: "Kata Benda")
                        CategoriesButton(categoriesImage: "Kata-sifat", categoriesName: "Kata Sifat")
                        CategoriesButton(categoriesImage: "Kata-kerja", categoriesName: "Kata Kerja")
                    }
                    .padding(.top, 10)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

struct ListCategories_Previews: PreviewProvider {
    static var previews: some View {
        ListCategories()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}



