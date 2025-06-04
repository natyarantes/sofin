//
//  FinancialTransaction.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//
//

import Foundation
import SwiftData


@Model public class FinancialTransaction {
    var amount: Double? = 0.0
    var date: Date?
    var id: UUID
    var title: String?
    var transactionType: String?
    public init(id: UUID) {
        self.id = id

    }
    
}
