//
//  Persistence.swift
//  sofin
//
//  Created by Natália Arantes on 26/05/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Exemplo de dados fake (pode remover ou ajustar)
        for i in 0..<5 {
            let newItem = FinancialTransaction(context: viewContext)
            newItem.id = UUID()
            newItem.title = "Transação \(i + 1)"
            newItem.amount = Double(i + 1) * 100
            newItem.date = Date()
            newItem.transactionType = i % 2 == 0 ? "income" : "expense"
        }

        do {
            try viewContext.save()
            print("✅ Preview Core Data salvo com sucesso.")
        } catch {
            let nsError = error as NSError
            fatalError("❌ Erro ao salvar preview: \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "sofin")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Erro ao carregar o Core Data: \(error), \(error.userInfo)")
            } else {
                print("✅ Core Data carregado: \(storeDescription)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
