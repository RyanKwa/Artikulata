//
//  BackButtonView.swift
//  Artikulata
//
//  Created by Minawati on 16/06/22.
//

import SwiftUI

struct BackButtonView: View {
    var body: some View {
        Button(action: {
            // action
        }){
            Circle()
                .fill(Color(red: 0.58, green: 0.45, blue: 0.49))
                .frame(width: 50, height: 50, alignment: .center)
                .overlay(
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 28, alignment: .leading)
                        .foregroundColor(.white)
                )
        }.buttonStyle(PlainButtonStyle())
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
