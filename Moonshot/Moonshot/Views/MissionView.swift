//
//  MissionView.swift
//  Moonshot
//
//  Created by Valentin Yang on 25/12/24.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission) {
        self.mission = mission
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Mision \(member.name)")
            }
            
        }
    }
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        VStack(spacing: 10) {
                            Text(mission.formattedlaunchDate)
                            Text("Mission Highlights")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                        }
                        Spacer()
                    }
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    HStack {
                        Spacer()
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Spacer()
                    }
                }
                .padding(.horizontal)
                
                MissionCrewView(crew: crew)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.darkBackground)
    }
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    MissionView(mission: missions[1])
        .preferredColorScheme(.dark)
}
