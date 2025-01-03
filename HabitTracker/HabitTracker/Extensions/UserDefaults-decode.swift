//
//  UserDefaults-decode.swift
//  HabitTracker
//
//  Created by Valentin Yang on 1/1/25.
//

import Foundation

extension UserDefaults {
    func decode<T: Codable>(_ type: T.Type, forKey key: String, defalutValue: T) -> T {
        if let data = self.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                return decoded
            }
        }
        
        return defalutValue
    }
}
