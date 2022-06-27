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
                //tite
                Text("Mau belajar apa hari ini?")
                    .font(Font.custom("FredokaOne-Regular", size: 32))
                    .multilineTextAlignment(.center)
                    
                Spacer()
                    .frame(height: 35)
                
                //buttons of categories
                HStack(alignment: .top, spacing: 27){
                    CategoriesButton(buttonColor: Color.redPastel, categoriesName: WordCategories.KataBenda)
                    CategoriesButton(buttonColor: Color.greenPastel, categoriesName: WordCategories.KataSifat)
                    CategoriesButton(buttonColor: Color.bluePastel, categoriesName: WordCategories.KataKerja)
                    }
                }
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



