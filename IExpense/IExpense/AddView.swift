//
//  AddView.swift
//  IExpense
//
//  Created by Valentin Yang on 20/12/24.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var expenses: [ExpenseItem]
    @State private var name = "Expense name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Enterprise", "Personal"]
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "usd"))
                        .keyboardType(.decimalPad)
                    HStack {
                        Button("Save") {
                            let item = ExpenseItem(name: name, type: type, amount: amount)
                            if type == "Personal" {
                                modelContext.insert(item)
                            }
                            else if type == "Enterprise" {
                                modelContext.insert(item)
                            }
                            dismiss()
                        }
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
            }
        }
    }
}

#Preview {
    
}
