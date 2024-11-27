//
//  ContentView.swift
//  WeSplit
//
//  Created by Valentin Yang on 22/11/24.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var selectedNumberPersonIndex = 0
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalToPay: Double {
        return checkAmount + checkAmount * Double(tipPercentage) / 100
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(selectedNumberPersonIndex + 2)
        return totalToPay / peopleCount
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $selectedNumberPersonIndex) {
                        ForEach(2..<100) { num in
                            Text("\(num) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Total to pay") {
                    Text(totalToPay, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Amount per preson") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
