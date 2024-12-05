//
//  ContentView.swift
//  BetterRest
//
//  Created by Valentin Yang on 3/12/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    static var defaultWakeupTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    @State private var sleepAmount: Double = 8
    @State private var wakeUpTime = defaultWakeupTime
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUpTime,
                               displayedComponents: .hourAndMinute)
                    .labelsHidden()
                }
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                    
                VStack(alignment: .leading, spacing: 0) {
                    
                    Picker(selection: $coffeeAmount) {
                        ForEach(1..<20) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                    } label: {
                        Text("Daily coffee intake").font(.headline)
                    }
                }
                Section {
                        HStack {
                            Spacer()
                            VStack {
                                Text("Your ideal bedtime is")
                                    .font(.title).fontWeight(.semibold)
                                Text("\(calculateBedTime().formatted(date: .omitted, time: .shortened))")
                                    .font(.title).fontWeight(.bold)
                            }
                            Spacer()
                        }
                }
                }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedTime() -> Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let wakeUpTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            
            let hoursInSeconds = (wakeUpTimeComponents.hour ?? 0) * 60 * 60
            let minutesInSecnods = (wakeUpTimeComponents.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hoursInSeconds + minutesInSecnods), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            
            return wakeUpTime - prediction.actualSleep
        } catch {
            return Date.now
        }
    }
}

#Preview {
    ContentView()
}
