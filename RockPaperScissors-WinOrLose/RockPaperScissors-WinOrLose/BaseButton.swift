//
//  BaseButton.swift
//  RockPaperScissors-WinOrLose
//
//  Created by Valentin Yang on 2/12/24.
//

import SwiftUI

struct BaseButton: View {
    let text: String
    let move: Int
    let buttonTapped: (Int) -> Void
    
    var body: some View {
        Button {
            buttonTapped(move)
        } label: {
            Text(text)
                .padding()
        }
        .background(Color(hex: "243647"))
        .clipShape(.capsule)
        .white()
    }
}

#Preview {
    ZStack {
        Color.blue
            .ignoresSafeArea()
        BaseButton(text: "✊🏻 Rock", move: 1, buttonTapped: {n in})
    }
}
