//
//  MissionsListView.swift
//  Moonshot
//
//  Created by Valentin Yang on 26/12/24.
//

import SwiftUI

struct MissionsListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                                VStack(alignment: .leading, spacing: 5) {
                                    Spacer()
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedlaunchDate)
                                        .font(.headline)
                                        .foregroundStyle(.white.opacity(0.5))
                                    Spacer()
                                }
                                .frame(height: .infinity)
                                .padding(.leading, 10)
                                Spacer()
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                }
            }
        }
        
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    MissionsListView(missions: missions, astronauts: astronauts)
        .background(.darkBackground)
}