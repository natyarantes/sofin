//
//  CoreDataTransactionsRepository.swift
//  sofin
//
//  Created by Natália Arantes on 16/08/25.
//

import Foundation
import CoreData

final class CoreDataTransactionsRepository: TransactionsRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchTransactions(in interval: DateInterval) throws -> [Transaction] {
        let request: NSFetchRequest<FinancialTransaction> = FinancialTransaction.fetchRequest()
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", interval.start as NSDate, interval.end as NSDate)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        let managed = try context.fetch(request)

        return managed.compactMap { (tx) -> Transaction? in
            // Garantias mínimas
            guard let date = tx.date else { return nil }

            // Mapeia tipo
            let type: TransactionType
            if let raw = tx.transactionType?.lowercased() {
                type = (raw == "income") ? .income : .expense
            } else {
                // Fallback pelo sinal do amount
                type = tx.amount >= 0 ? .income : .expense
            }

            // Usamos 'title' como “categoria” por enquanto
            let rawTitle = (tx.title ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            let category = rawTitle.isEmpty ? "Sem categoria" : rawTitle

            return Transaction(
                amount: tx.amount,
                date: date,
                type: type,
                category: category
            )
        }
    }
}
