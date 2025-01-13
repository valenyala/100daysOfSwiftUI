//
//  ContentView.swift
//  IExpense
//
//  Created by Valentin Yang on 20/12/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var order = [SortDescriptor<ExpenseItem>(\.name)]

    @State private var showingAddExpense = false

    @State private var showPersonalExpenses = true

    @State private var showEnterpriseExpenses = true

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if showPersonalExpenses {
                    ListView(
                        expenseType: "Personal",
                        sortOrder: order
                    )
                }
                if showEnterpriseExpenses {
                    ListView(
                        expenseType: "Enterprise",
                        sortOrder: order
                    )
                }
                if showPersonalExpenses && showEnterpriseExpenses {
                    Spacer()
                        .frame(maxWidth: .infinity)
                        .scrollContentBackground(.hidden)
                        .background(Color.gray.opacity(0.2))
                }
            }
            .navigationTitle("IExpense")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    NavigationLink(destination: AddView()) {
                        Label("Add expense", systemImage: "plus")
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort by", selection: $order) {
                            Text("Sort by name").tag([SortDescriptor<ExpenseItem>(\.name)])
                            Text("Sort by amount").tag([SortDescriptor<ExpenseItem>(\.amount)])
                        }
                    }
                }

                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Personal") {
                        showPersonalExpenses.toggle()
                    }
                    Button("Enterprise") {
                        showEnterpriseExpenses.toggle()
                    }
                    Button("All") {
                        showPersonalExpenses = true
                        showEnterpriseExpenses = true
                    }
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
