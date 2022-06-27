//
//  Background.swift
//  Artikulata
//
//  Created by Minawati on 26/06/22.
//

import SwiftUI

struct Background : View {
    var backgroundImage : String = "BG-kata-sifat"
    
    var body: some View {
        Image(backgroundImage)
            .resizable()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
