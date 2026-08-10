//
//  GitPulseApp.swift
//  GitPulse
//
//  Created by Manuel              on 08/08/2026.
//

import SwiftUI

@main
struct GitPulseApp: App {
    
    init() {
        let syncService = RepositorySyncService()
        syncService.sync()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
