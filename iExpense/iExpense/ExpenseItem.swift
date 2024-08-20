//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Mike Colvin on 4/10/23.
//

import Foundation

struct ExpenseItem: Hashable, Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
}
