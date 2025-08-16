//
//  HomeViewModelTests.swift
//  sofin
//
//  Created by Natália Arantes on 04/06/25.
//

import XCTest
import CoreData
@testable import sofin

final class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        context = makeInMemoryContext()
        sut = HomeViewModel(context: context)
    }

    override func tearDownWithError() throws {
        sut = nil
        context = nil
    }

    func test_fetchTransactions_shouldReturnOnlyValidTransactions() throws {
        let valid = FinancialTransaction(context: context)
        valid.id = UUID()
        valid.title = "Salário"
        valid.amount = 5000
        valid.date = Date()
        valid.transactionType = "income"

        let invalid = FinancialTransaction(context: context)
        invalid.title = "Transação inválida"

        try context.save()

        sut.fetchTransactions()

        XCTAssertEqual(sut.transactions.count, 1)
        XCTAssertEqual(sut.transactions.first?.title, "Salário")
    }

    func test_calculateBalance_shouldComputeCorrectValues() throws {
        let income = FinancialTransaction(context: context)
        income.id = UUID()
        income.title = "Renda"
        income.amount = 5000
        income.date = Date()
        income.transactionType = "income"

        let expense = FinancialTransaction(context: context)
        expense.id = UUID()
        expense.title = "Aluguel"
        expense.amount = 2000
        expense.date = Date()
        expense.transactionType = "expense"

        try context.save()

        sut.fetchTransactions()

        XCTAssertEqual(sut.incomeTotal, 5000)
        XCTAssertEqual(sut.expenseTotal, 2000)
        XCTAssertEqual(sut.totalBalance, 3000)
    }

    // MARK: - Helper

    private func makeInMemoryContext() -> NSManagedObjectContext {
        let container = NSPersistentContainer(name: "sofin")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Erro ao configurar contexto in-memory: \(error)")
            }
        }
        return container.viewContext
    }
}
