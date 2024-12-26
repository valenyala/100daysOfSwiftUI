//
//  Mission.swift
//  Moonshot
//
//  Created by Valentin Yang on 24/12/24.
//

import Foundation


struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedlaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }

    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}
