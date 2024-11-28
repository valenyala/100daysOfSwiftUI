//
//  ContentView.swift
//  UnitConverter
//
//  Created by Valentin Yang on 26/11/24.
//

import SwiftUI

struct ContentView: View {
    let units = ["milliseconds", "seconds", "minutes", "hours"]
    @FocusState private var focused: Bool
    @State private var inputValue: Double = 0
    @State private var inputUnit: String = "milliseconds"
    @State private var outputUnit: String = "milliseconds"
    
    func stringToMesurement(from unit: String) -> UnitDuration{
        switch(unit.lowercased()) {
        case "hours":
            return UnitDuration.hours
        case "minutes":
            return UnitDuration.minutes
        case "seconds":
            return UnitDuration.seconds
        default:
            return UnitDuration.milliseconds
        }
    }
    
    private var result: String {
        let startingMesurement = Measurement(value: inputValue, unit: stringToMesurement(from: inputUnit))
        
        return startingMesurement.converted(to: stringToMesurement(from: outputUnit)).formatted()
    }

    var body: some View {
        Form {
            Section("From") {
                TextField("Value", value: $inputValue, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($focused)
                Picker("Unit", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0.capitalized)
                    }
                }
            }
            Section("To") {
                Picker("Unit", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0.capitalized)
                    }
                }
            }
            
            Section("Result") {
                Text(result)
            }

        }
        .toolbar {
            if focused {
                Button("Done") {
                    focused = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
