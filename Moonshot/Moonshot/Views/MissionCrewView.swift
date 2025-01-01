//
//  MissionCrewView.swift
//  Moonshot
//
//  Created by Valentin Yang on 26/12/24.
//

import SwiftUI

struct MissionCrewView: View {
    let crew: [MissionView.CrewMember]
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { crewMember in
//                        NavigationLink {
//                            AstronautView(astronaut: crewMember.astronaut)
//                        } label: {
                        NavigationLink(value: crewMember.astronaut) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(.capsule)
                                    .overlay(
                                        Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                    )
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                }
                                .padding(.horizontal)
                            }
                        .navigationDestination(for: Astronaut.self,
                                               destination: { astronaut in
                            AstronautView(astronaut: astronaut)
                        })
                    }
                }
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let mission = missions[0]
    let crew = mission.crew.map { member in
        if let astronaut = astronauts[member.name] {
            return MissionView.CrewMember(role: member.role, astronaut: astronaut)
        } else {
            fatalError("Mision \(member.name)")
        }
        
    }
    NavigationStack {
        MissionCrewView(crew: crew)
            .navigationTitle("Crew")
            .background(.darkBackground)
    }
}
