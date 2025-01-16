//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Valentin Yang on 13/1/25.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
