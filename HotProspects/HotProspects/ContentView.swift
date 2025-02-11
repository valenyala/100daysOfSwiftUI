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
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
            .tabItem {
                Label("Contacted", systemImage: "checkmark.circle")
            }
            ProspectsView(filter: .uncontacted)
            .tabItem {
                Label("Uncontacted", systemImage: "questionmark.diamond")
            }
            AboutMeView()
            .tabItem {
                Label("Me", systemImage: "person")
            }
        }
    }
}


#Preview {
    ContentView()
}
