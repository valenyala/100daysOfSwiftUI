//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Valentin Yang on 31/1/25.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
