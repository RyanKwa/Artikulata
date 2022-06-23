//
//  CategoriesButton.swift
//  Artikulata
//
//  Created by Shaqina Yasmin on 22/06/22.
//

import SwiftUI

struct CategoriesButton: View {
    var buttonColor : Color
    var categoriesName : String
    
    @State var isActive = false
    
    
    
    var body: some View {
    
        Button {
            self.isActive = true
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 27)
                    .fill(buttonColor)
                    .frame(minWidth: 0, maxWidth: 222, minHeight: 166,maxHeight: 166)
                FontView(text: categoriesName, size: 26)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            
                NavigationLink(destination: ListWordView(categoriesName: categoriesName).navigationBarBackButtonHidden(true), isActive: $isActive){
                }.hidden()
            
        )
        
    }
}

struct CategoriesButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesButton(buttonColor: Color.greenPastel, categoriesName: "Kata Sifat")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

