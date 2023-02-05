//
//  ContentView.swift
//  BetterRest
//
//  Created by Mike Colvin on 2/2/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents:
                            .hourAndMinute)
                    .labelsHidden()
                }  // End of Section
                
                Section(header: Text("Desired amount of sleep")) {
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }  // End of Section
                
                Section(header: Text("Daily coffee intake")) {
                    
                    //                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    Picker((coffeeAmount == 1) ? "Cup" : "Cups", selection: $coffeeAmount, content: {
                        ForEach(0..<20, content: { index in
                            Text("\(index)")
                        })
                    })
                }  // End of Section
                
                Section(header: Text("Your bedtime should be:")) {
                    HStack {
                        Text(calculateBedtime())
                            .font(.largeTitle.weight(.semibold))
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                }
                
            }  // end of Form
            .navigationTitle("BetterRest")
        }  // end of NavigationView
        
    }  // end of body
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep

//            alertTitle = "Your ideal bedtime is…"
            return sleepTime.formatted(date: .omitted, time: .shortened)

        } catch {
            // Something went wrong
//            alertTitle = "Error"
            return "Sorry, there was a problem calculating your bedtime."
        }
//        showingAlert = true
    }
}  // end of ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
