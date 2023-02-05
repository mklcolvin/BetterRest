//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael Colvin on 11/3/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]

    
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
                
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
        
    }
    
    var calcTotal: Double {
        let tipSelect = Double(tipPercentage)
        let tipVal = checkAmount / 100 * tipSelect
        let runningTotal = checkAmount + tipVal
        
        return runningTotal
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach (2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                     }
                    .pickerStyle(.menu)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(calcTotal, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Grand total of Check")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar
            {
               ToolbarItemGroup(placement: .keyboard) {
                   Spacer()
                   Button("Done") {
                       amountIsFocused = false
                   }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
