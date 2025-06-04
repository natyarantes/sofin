//
//  HomeViewModel.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import Foundation
import CoreData

final class HomeViewModel: ObservableObject {
    
    @Published var transactions: [TransactionModel] = []
    @Published var totalBalance: Double = 0.0
    @Published var incomeTotal: Double = 0.0
    @Published var expenseTotal: Double = 0.0

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchTransactions()
    }

    func refresh() {
        fetchTransactions()
    }

    func fetchTransactions() {
        let request: NSFetchRequest<FinancialTransaction> = FinancialTransaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FinancialTransaction.date, ascending: false)]

        do {
            let results = try context.fetch(request)
            self.transactions = results.compactMap { transaction in
                guard
                    let id = transaction.id,
                    let date = transaction.date,
                    let typeString = transaction.transactionType,
                    let type = TransactionModel.FinancialType(rawValue: typeString)
                else {
                    print("⚠️ Transação incompleta. Ignorada.")
                    return nil
                }

                return TransactionModel(
                    id: id,
                    title: transaction.title ?? "Sem título",
                    amount: transaction.amount,
                    date: date,
                    financialType: type
                )
            }
            calculateBalance()
        } catch {
            print("❌ Erro ao buscar transações: \(error)")
            self.transactions = []
        }
    }

    private func calculateBalance() {
        incomeTotal = transactions
            .filter { $0.financialType.rawValue == "income" }
            .reduce(0) { $0 + $1.amount }

        expenseTotal = transactions
            .filter { $0.financialType.rawValue == "expense" }
            .reduce(0) { $0 + $1.amount }

        totalBalance = incomeTotal - expenseTotal
    }
}


