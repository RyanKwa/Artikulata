//
//  ArtikulataApp.swift
//  Artikulata
//
//  Created by Ryan Vieri Kwa on 08/06/22.
//

import SwiftUI

@main
struct ArtikulataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ListWordView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
