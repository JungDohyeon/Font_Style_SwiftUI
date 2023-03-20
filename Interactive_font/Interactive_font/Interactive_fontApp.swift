//
//  Interactive_fontApp.swift
//  Interactive_font
//
//  Created by 정도현 on 2023/03/19.
//

import SwiftUI

@main
struct Interactive_fontApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
