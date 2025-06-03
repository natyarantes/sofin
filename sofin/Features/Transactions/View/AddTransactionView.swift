//
//  AddTransactionView.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI
import Foundation

struct AddTransactionView: View {
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: AddTransactionViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Valor")) {
                    TextField("Ex: 150.00", text: $viewModel.amount)
                        .keyboardType(.decimalPad)
                        .onChange(of: viewModel.amount) {
                            viewModel.amount = viewModel.amount.replacingOccurrences(of: ",", with: ".")
                            .filter { "0123456789.".contains($0)}}
                }
                
                Section(header: Text("Descrição")) {
                    TextField("Ex: transporte, aluguel...", text: $viewModel.title)
                }
                Section(header: Text("Tipo")) {
                    Picker("Tipo", selection: $viewModel.type) {
                        ForEach(AddTransactionViewModel.TransactionType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Debug")) {
                    Button("Verificar Contexto") {
                        print("✅ Contexto recebido: \(context)")
                        print("📍 Tem alterações pendentes? \(context.hasChanges)")
                    }
                }
                Button("Forçar alteração") {
                    let transaction = FinancialTransaction(context: context)
                    transaction.id = UUID()
                    transaction.title = "Teste forçado"
                    transaction.amount = 99.99
                    transaction.date = Date()
                    transaction.transactionType = "income"
                    
                    context.insert(transaction) // 👈 força o Core Data a saber que é novo

                    if context.hasChanges {
                        do {
                            print("ENTITY NAME: \(transaction.entity.name ?? "❌")")
                            print("IS FAULT: \(transaction.isFault)")
                            print("INSERTED: \(transaction.isInserted)")

                            try context.save()
                            print("✅ Salvou forçando alteração!")
                        } catch {
                            print("❌ Erro ao salvar (forçado): \(error)")
                        }
                    } else {
                        print("⚠️ Ainda sem alterações, mesmo forçando")
                    }
                }
            }
            .navigationTitle("Nova transação")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        viewModel.saveTransaction(using: context)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Fechar", systemImage: "xmark")
                    }
                }
            }
        }
    }
}
