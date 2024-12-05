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
    @State private var coffeeAmount = 1
    
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
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                }
                }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let wakeUpTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            
            let hoursInSeconds = (wakeUpTimeComponents.hour ?? 0) * 60 * 60
            let minutesInSecnods = (wakeUpTimeComponents.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hoursInSeconds + minutesInSecnods), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUpTime - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bed time"
        }
        
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
