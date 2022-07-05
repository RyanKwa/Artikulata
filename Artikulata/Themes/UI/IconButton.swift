//
//  IconButton.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 04/07/22.
//

import SwiftUI

struct IconButton: View {
    /// Untuk button dengan icon
    var iconName: String
    var body: some View {
        Circle()
            .fill(Color(red: 0.58, green: 0.45, blue: 0.49))
            .frame(width: 50, height: 50, alignment: .center)
            .overlay(
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 28, alignment: .leading)
                    .foregroundColor(.white)
            )
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(iconName: "chevron.backward")
    }
}
