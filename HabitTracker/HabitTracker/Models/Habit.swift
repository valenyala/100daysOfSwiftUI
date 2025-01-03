//
//  Habit.swift
//  HabitTracker
//
//  Created by Valentin Yang on 1/1/25.
//

import Foundation

@Observable
class HabitTracker {
    var habits = UserDefaults.standard.decode([Habit].self, forKey: "Habits", defalutValue: [Habit]()) {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
}
struct Habit: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var timesCompleted: Int
}
