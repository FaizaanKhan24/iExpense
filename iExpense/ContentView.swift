//
//  ContentView.swift
//  iExpense
//
//  Created by Faizaan Khan on 1/8/23.
//

import SwiftUI

struct ExpenseView: View{
    var expense : ExpenseItem
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                    .foregroundColor(getTextColor(amount: expense.amount))
                Text(expense.type)
            }
            
            Spacer()
            
            Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                            .foregroundColor(textColor(amount: item.amount))
        }
    }
    
    func getTextColor(amount: Double) -> Color{
        if amount < 10 {
            return Color.green
        }
        else if amount > 100 {
            return Color.red
        }
        else {
            return Color.orange
        }
    }
}

struct ContentView: View {
    @State private var showingAddExpense = false
    
    @StateObject var expenses = Expenses()
    
    var body: some View {
        NavigationView{
            List{
                Section("Personal"){
                    ForEach(expenses.items){item in
                        if(item.type == "Personal"){
                            ExpenseView(expense: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section("Business"){
                    ForEach(expenses.items){item in
                        if(item.type == "Business"){
                            ExpenseView(expense: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
//    func getTextColor(amount: Double) -> Color{
//        if amount < 10 {
//            return Color.green
//        }
//        else if amount > 100 {
//            return Color.red
//        }
//        else {
//            return Color.orange
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
