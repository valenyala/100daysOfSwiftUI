//
//  ContentView.swift
//  HotProspects
//
//  Created by Valentin Yang on 31/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "One"

    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")

            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}


#Preview {
    ContentView()
}
