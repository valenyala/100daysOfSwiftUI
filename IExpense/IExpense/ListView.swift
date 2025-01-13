//
//  ListView.swift
//  IExpense
//
//  Created by Valentin Yang on 22/12/24.
//

import SwiftData
import SwiftUI

struct ListView: View {
    @Environment(\.modelContext) var modelContext

    var expenseType: String
    @Query var expenses: [ExpenseItem]

    init(
        expenseType: String,
        sortOrder: [SortDescriptor<ExpenseItem>]
    ) {
        self.expenseType = expenseType
        _expenses = Query(
            filter: #Predicate { item in
                item.type == expenseType
            }, sort: sortOrder)
    }

    var body: some View {
        List {
            Text(expenseType)
                .font(.title2)
                .fontWeight(.bold)
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }

                    Spacer()
                    Text(
                        item.amount,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .foregroundStyle(changeColor(of: item.amount))
                }
            }
            .onDelete(perform: removePesonalItem)
        }
        .scrollContentBackground(.hidden)
        .background(Color.gray.opacity(0.2))
    }

    func changeColor(of amount: Double) -> Color {
        if amount < 10 {
            return .green
        } else if amount < 100 {
            return .yellow
        } else {
            return .red
        }
    }
    func removePesonalItem(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
}
