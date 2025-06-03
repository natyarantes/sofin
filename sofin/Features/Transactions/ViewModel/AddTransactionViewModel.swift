//
//  AddTransactionViewModel.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import Foundation

final class AddTransactionViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var amount: String = ""
    @Published var type: TransactionType = .income
    
    enum TransactionType: String, CaseIterable, Identifiable {
        case income = "Entrada"
        case expense = "Saída"
        
        var id: String { rawValue }
    }
    
    func saveTransaction() {
        print("💾 Recording transaction: \(type.rawValue) de \(amount) para \(title)")
    }
}
