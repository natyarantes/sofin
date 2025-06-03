//
//  Persistence.swift
//  sofin
//
//  Created by Natália Arantes on 26/05/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Versão de preview para SwiftUI (opcional, útil em testes e previews)
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
            newItem.type = i % 2 == 0 ? "income" : "expense"
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Erro ao salvar preview: \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "sofin") // ⚠️ Nome deve ser o mesmo do seu .xcdatamodeld
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Erro ao carregar o Core Data: \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
