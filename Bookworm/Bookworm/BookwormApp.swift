//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Valentin Yang on 9/1/25.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
