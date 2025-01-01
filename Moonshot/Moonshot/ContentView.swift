//
//  ContentView.swift
//  Moonshot
//
//  Created by Valentin Yang on 24/12/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showGridView = true
    
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        ZStack {
            NavigationStack(path: $navigationPath) {
                Group {
                    if showGridView {
                        MissionGridView(missions: missions)
                    }
                    else {
                        MissionsListView(missions: missions)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .navigationTitle("Moonshot")
                .toolbar {
                    Button(showGridView ? "List view" : "Grid view") {
                        showGridView.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(.darkBackground)
    }
}

#Preview {
    ContentView()
}
