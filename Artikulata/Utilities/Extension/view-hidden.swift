//
//  view-hidden.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 22/06/22.
//

import Foundation
import SwiftUI
public extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove{
                self.hidden()
            }
        }
        else{
            self
        }
    }
}
