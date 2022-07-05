//
//  CategoriesButton.swift
//  Artikulata
//
//  Created by Shaqina Yasmin on 22/06/22.
//

import SwiftUI

struct CategoriesButton: View {
    var modulKategori: KategoriModel?
    @State var isActive = false
    
    var body: some View {
        Button {
            self.isActive = true
        } label: {
            VStack {
                if let categoryImage = modulKategori?.kategoriImage, let categoryName = modulKategori?.kategoriKata?.rawValue {
                    Image(categoryImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 221, height: 166)
                        .cornerRadius(20)
                    FontView(text: categoryName, size: 26)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            //MARK: change from force unwrap to other safe unwrap
            NavigationLink(destination: ListWordView(modulKategori: modulKategori!).navigationBarTitle("").navigationBarHidden(true), isActive: $isActive){
            }.hidden()
            
        )
        
    }
}

struct CategoriesButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesButton(modulKategori: KategoriModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

