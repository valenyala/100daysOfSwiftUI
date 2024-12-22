//
//  ExpenseItem.swift
//  IExpense
//
//  Created by Valentin Yang on 20/12/24.
//

import Foundation

@Observable
class Expenses {
    private static let PERSONAL_ITEMS = "PERSONAL_ITEMS"
    private static let ENTREPRISE_ITEMS = "ENTERPRISE_ITEMS"
    var personalItems = [ExpenseItem]() {
        didSet {
            if let encodedItems = try? JSONEncoder().encode(personalItems) {
                UserDefaults.standard.set(encodedItems, forKey: Expenses.PERSONAL_ITEMS)
            }
        }
    }
    
    var enterpriseItems = [ExpenseItem]() {
        didSet {
            if let encodedItems = try? JSONEncoder().encode(enterpriseItems) {
                UserDefaults.standard.set(encodedItems, forKey: Expenses.ENTREPRISE_ITEMS)
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: Expenses.PERSONAL_ITEMS) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                personalItems = decodedItems
            }
        }
        
        if let savedItems = UserDefaults.standard.data(forKey: Expenses.ENTREPRISE_ITEMS) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                enterpriseItems = decodedItems
            }
        }
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
