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
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack {
            ListView(expenses: expenses)
            .navigationTitle("IExpense")
            .toolbar {
                NavigationLink(destination: AddView(expenses: expenses)) {
                    Label("Add expense", systemImage: "plus")
                }
            }
        }
//        .sheet(isPresented: $showingAddExpense) {
//            AddView(expenses: expenses)
//        }
    }
    
    
}

#Preview {
    ContentView()
}
