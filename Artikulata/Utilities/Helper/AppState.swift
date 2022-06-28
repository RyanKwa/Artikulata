//
//  AppState.swift
//  Artikulata
//
//  Created by Minawati on 28/06/22.
//

import Foundation
import Combine

class AppState: ObservableObject {
    @Published var rootViewId = UUID()
}
