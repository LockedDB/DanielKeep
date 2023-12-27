//
//  DanielKeepApp.swift
//  DanielKeep
//
//  Created by Dani Benet on 26/12/23.
//

import SwiftUI

@main
struct DanielKeepApp: App {
    private var navigationModel = NavigationModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationModel)
        }
    }
}
