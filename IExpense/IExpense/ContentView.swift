//
//  ContentView.swift
//  IExpense
//
//  Created by Valentin Yang on 20/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            ListView(expenses: expenses)
            .navigationTitle("IExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    
}

#Preview {
    ContentView()
}
