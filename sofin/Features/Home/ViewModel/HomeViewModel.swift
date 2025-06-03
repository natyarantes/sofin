//
//  HomeViewModel.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import Foundation
import CoreData

final class HomeViewModel: ObservableObject {
    
    @Published var transactions: [FinancialTransaction] = []
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

    private func fetchTransactions() {
        let request: NSFetchRequest<FinancialTransaction> = FinancialTransaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FinancialTransaction.date, ascending: false)]

        do {
            transactions = try context.fetch(request)
            calculateBalance()
        } catch {
            print("Erro ao buscar transações: \(error.localizedDescription)")
            transactions = []
            incomeTotal = 0
            expenseTotal = 0
            totalBalance = 0
        }
    }

    private func calculateBalance() {
        incomeTotal = transactions
            .filter { $0.type == "income" }
            .reduce(0) { $0 + $1.amount }

        expenseTotal = transactions
            .filter { $0.type == "expense" }
            .reduce(0) { $0 + $1.amount }

        totalBalance = incomeTotal - expenseTotal
    }
}


