//
//  DanielKeepApp.swift
//  DanielKeep
//
//  Created by Dani Benet on 26/12/23.
//

import SwiftUI
import SwiftData

@main
struct DanielKeepApp: App {
    
    let container: ModelContainer = {
        let schema = Schema([Note.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
}
