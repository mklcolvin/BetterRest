//
//  ContentView.swift
//  iExpense
//
//  Created by Mike Colvin on 4/7/23.
//

import SwiftUI


struct ContentView: View {
    @State var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            NavigationView {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
//                            Spacer()
                            
                            Text(item.amount, format: .currency(code: "USD"))
                            NavigationLink (""){
                                ShowView(item: item)
                            }
                        }
                    }
                    //                .onDelete(perform: removeItems)
                }
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink("+") {
                        AddView(expenses: $expenses)
                    }
                }
                //            .sheet(isPresented: $showingAddExpense) {
                //                AddView(expenses: expenses)
                //           }
            }
            //       func removeItems(at offsets: IndexSet) {
            //            expenses.items.remove(atOffsets: offsets)
            //        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
