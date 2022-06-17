//
//  FontView.swift
//  Artikulata
//
//  Created by Minawati on 14/06/22.
//

import SwiftUI

struct FontView: View {
    
    let text: String
    let size: Int
    
    var body: some View {
        Text(text)
            .font(Font.custom("FredokaOne-Regular", size: CGFloat(size)))
    }
}

struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        FontView(text: "text", size: 32)
    }
}
