//
//  sofinApp.swift
//  sofin
//
//  Created by Natália Arantes on 26/05/25.
//

import SwiftUI

@main
struct sofinApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
