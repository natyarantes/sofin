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

    func saveTransaction(using context: NSManagedObjectContext) {
        let transaction = FinancialTransaction(context: context)
        transaction.id = UUID()
        transaction.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        transaction.amount = Double(amount.replacingOccurrences(of: ",", with: ".")) ?? 0
        transaction.date = Date()
        transaction.transactionType = (type == .income) ? "income" : "expense"

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            print("❌ Erro ao salvar: \(nsError), \(nsError.userInfo)")
        }
    }
}

