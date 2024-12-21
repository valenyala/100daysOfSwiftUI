//
//  ExpenseItem.swift
//  IExpense
//
//  Created by Valentin Yang on 20/12/24.
//

import Foundation

@Observable
class Expenses {
    private static let ITEMS = "ITEMS"
    var items = [ExpenseItem]() {
        didSet {
            if let encodedItems = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encodedItems, forKey: Expenses.ITEMS)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: Expenses.ITEMS) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
