//
//  CategoriesButton.swift
//  Artikulata
//
//  Created by Shaqina Yasmin on 22/06/22.
//

import SwiftUI

struct CategoriesButton: View {
    var categoriesImage : String
    var categoriesName : WordCategories
    
    @State var isActive = false
    
    var body: some View {
        Button {
            self.isActive = true
        } label: {
            VStack {
                Image(categoriesImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 221, height: 166)
                    .cornerRadius(20)
                FontView(text: categoriesName.rawValue, size: 26)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            NavigationLink(destination: ListWordView(categoriesName: categoriesName).navigationBarTitle("").navigationBarHidden(true), isActive: $isActive){
            }.hidden()
            
        )
        
    }
}

struct CategoriesButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesButton(categoriesImage: "Kata-sifat", categoriesName: WordCategories.KataSifat)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

