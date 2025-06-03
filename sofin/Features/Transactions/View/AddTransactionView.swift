//
//  AddTransactionView.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI
import Foundation

struct AddTransactionView: View {
    
    @ObservedObject var viewModel: AddTransactionViewModel
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Valor")) {
                    TextField("Ex: 150.00", text: $viewModel.amount)
                        .keyboardType(.decimalPad)
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
                        viewModel.saveTransaction(context: context)
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
