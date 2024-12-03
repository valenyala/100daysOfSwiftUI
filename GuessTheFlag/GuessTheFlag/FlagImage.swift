//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Valentin Yang on 2/12/24.
//

import SwiftUI

struct FlagImage: View {
    let flagName: String
    let number: Int
    let flagTapped: (Int) -> Void
    var body: some View {
        Button {
            flagTapped(number)
        } label: {
            Image(flagName)
                .clipShape(.capsule)
                .shadow(radius: 0)
        }    }
    
}

#Preview {
    FlagImage(flagName: "Spain", number: 1, flagTapped: {number in})
}
