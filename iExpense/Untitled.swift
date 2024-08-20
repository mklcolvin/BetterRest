//
//  Untitled.swift
//  iExpense
//
//  Created by Mike Colvin on 8/16/24.
//

NavigationView {
    List {
        ForEach(expenses.items) { item in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.type)
                }

                Spacer()

                Text(item.amount, format: .currency(code: "USD"))
            }
        }
        .onDelete(perform: removeItems)
    }
    .navigationTitle("iExpense")
    .toolbar {
        NavigationLink("+") {
            AddView(expenses: expenses)
        }
    }
//            .sheet(isPresented: $showingAddExpense) {
//                AddView(expenses: expenses)
//           }
}
