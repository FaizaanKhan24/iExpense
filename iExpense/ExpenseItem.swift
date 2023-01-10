//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Faizaan Khan on 1/8/23.
//

import Foundation

struct ExpenseItem : Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
