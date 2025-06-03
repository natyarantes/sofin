//
//  AddTransactionViewModel.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import Foundation
import CoreData

final class AddTransactionViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var amount: String = ""
    @Published var type: TransactionType = .income
    
    enum TransactionType: String, CaseIterable, Identifiable {
        case income = "Entrada"
        case expense = "Saída"
        
        var id: String { rawValue }
    }
    
    func saveTransaction(context: NSManagedObjectContext) {
        let transaction = FinancialTransaction(context: context)
        transaction.id = UUID()
        transaction.title = title
        transaction.amount = Double(amount) ?? 0
        transaction.date = Date()
        transaction.type = type == .income ? "income" : "expense"
        
        do {
            try context.save()
            print("💾 Recording transaction: \(type.rawValue) de \(amount) para \(title)")
        } catch {
            print("😱 Failed to save transaction: \(error)")
        }
    }
}
