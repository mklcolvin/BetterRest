//
//  ShowView.swift
//  iExpense
//
//  Created by Mike Colvin on 4/14/23.
//

import SwiftUI

struct ShowView: View {
    
//    @Binding var expenses: Expenses
    
    var item: ExpenseItem
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    HStack {
                        Text("Name:")
                            .bold()
                        Text(item.name)
                        
                    }
                    HStack {
                        Text("Type: ")
                            .bold()
                        Text(item.type)
                    }
                    HStack {
                        Text("Amount: ")
                            .bold()
                        Text(String(item.amount))
                    }
                   
                }
    
                
//                Picker("Type", selection: $type) {
//                    ForEach(types, id: \.self) {
//                        Text($0)
//                    }
//                }
//                TextField("Amount", value: $amount, format: .currency(code: "USD"))
//                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Show Expense")
            .toolbar {
                Button("Done") {
//                    let item = ExpenseItem(name: name, type: type, amount: amount)
//                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct ShowView_Previews: PreviewProvider {
    
    @State static var expenses = Expenses()
    
    static var previews: some View {
        ShowView(item: expenses.items[0])
    }
}
