//
//  ListView.swift
//  IExpense
//
//  Created by Valentin Yang on 22/12/24.
//

import SwiftUI

struct ListView: View {
    var expenses: Expenses
    var body: some View {
                List {
                    Text("Personal")
                        .font(.title2)
                        .fontWeight(.bold)
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(changeColor(of : item.amount))
                        }
                    }
                    .onDelete(perform: removePesonalItem)
                    Spacer()
                    Text("Enterprise")
                        .font(.title2)
                        .fontWeight(.bold)
                    ForEach(expenses.enterpriseItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(changeColor(of : item.amount))
                        }
                    }
                    .onDelete(perform: removeEnterpriseItem)
        }
    }

    func changeColor(of amount: Double) -> Color {
        if amount < 10 {
            return .green
        }
        else if amount < 100 {
            return .yellow
        }
        else { return .red }
    }
    func removePesonalItem(at offsets: IndexSet) {
        expenses.personalItems.remove(atOffsets: offsets)
    }
    func removeEnterpriseItem(at offsets: IndexSet) {
        expenses.enterpriseItems.remove(atOffsets: offsets)
    }
}

#Preview {
    ListView(expenses: Expenses())
}
