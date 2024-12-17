//
//  ContentView.swift
//  Animations
//
//  Created by Valentin Yang on 6/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var rectangleShown = true
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    rectangleShown.toggle()
                }
            }

            if rectangleShown {
                Rectangle()
                    .fill(.red)
                    .stroke(.blue)
                    .frame(width: 200, height: 200)
                    .transition(.scale)
            }
        }
    }
}

#Preview {
    ContentView()
}
