//
//  AddTransactionView.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI
import Foundation

struct AddTransactionView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AddTransactionViewModel
    
    var context = PersistenceController.shared.container.viewContext
    
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
