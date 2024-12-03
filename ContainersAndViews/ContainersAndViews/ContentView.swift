//
//  ContentView.swift
//  ContainersAndViews
//
//  Created by Valentin Yang on 30/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            Button("Hello, World!") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(.red)
            .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
    }
}

#Preview {
    ContentView()
}
