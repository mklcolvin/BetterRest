//
//  ContentView.swift
//  iExpense
//
//  Created by Mike Colvin on 4/7/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
Nav                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("iExpense")
            .navigationDestination(for: String.self, destination: <#T##(Hashable) -> View#>)
           }
//        func removeItems(at offsets: IndexSet) {
//            expenses.items.remove(atOffsets: offsets)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
