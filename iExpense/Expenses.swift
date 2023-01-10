//
//  Expenses.swift
//  iExpense
//
//  Created by Faizaan Khan on 1/8/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encodedData = try? encoder.encode(items){
                UserDefaults.standard.set(encodedData, forKey: "Items")
            }
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        
        if let savedData = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? decoder.decode([ExpenseItem].self, from: savedData){
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
