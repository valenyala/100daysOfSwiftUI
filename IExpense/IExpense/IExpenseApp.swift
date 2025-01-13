//
//  IExpenseApp.swift
//  IExpense
//
//  Created by Valentin Yang on 20/12/24.
//

import SwiftUI
import SwiftData

@main
struct IExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
