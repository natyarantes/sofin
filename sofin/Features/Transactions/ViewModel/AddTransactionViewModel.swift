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
        
        print("isInserted: \(transaction.isInserted)")

        
        transaction.id = UUID()
        print("✅ id: \(transaction.id?.uuidString ?? "nil")")
        
        transaction.title = title
        print("✅ title: \(transaction.title ?? "nil")")
        
        transaction.amount = Double(amount) ?? 0
        print("✅ amount: \(transaction.amount)")
        
        transaction.date = Date()
        print("✅ date: \(transaction.date!)")
        
        transaction.type = type == .income ? "income" : "expense"
        print("✅ type: \(transaction.type ?? "nil")")
        
        if context.hasChanges {
            do {
                try context.save()
                print("💾 Saved successfully!")
            } catch {
                let nsError = error as NSError
                print("❌ Save failed: \(nsError), \(nsError.userInfo)")
            }
        } else {
            print("⚠️ Nada mudou - contexto sem alterações detectadas.")
        }
    }

}
