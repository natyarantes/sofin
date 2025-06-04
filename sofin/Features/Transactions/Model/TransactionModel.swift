//
//  TransactionModel.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import Foundation
import CoreData

struct TransactionModel: Identifiable {
    let id: UUID
    let title: String
    let amount: Double
    let date: Date
    let financialType: FinancialType

    enum FinancialType: String {
        case income, expense
    }
}
