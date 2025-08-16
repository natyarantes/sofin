//
//  ReportModels.swift
//  sofin
//
//  Created by Natália Arantes on 16/08/25.
//

import Foundation

enum TransactionType {
    case income
    case expense
}

struct Transaction {
    let amount: Double
    let date: Date
    let type: TransactionType
    let category: String
}

struct CategoryTotal: Identifiable, Equatable {
    let id = UUID()
    let category: String
    let total: Double
}

struct ReportSummary: Equatable {
    let incomeTotal: Double
    let expenseTotal: Double
    var balance: Double { incomeTotal - expenseTotal }
    let categoryTotals: [CategoryTotal] 
}

struct ReportMonth {
    let monthDate: Date
    var interval: DateInterval {
        let cal = Calendar.current
        let start = cal.date(from: cal.dateComponents([.year, .month], from: monthDate))!
        let end = cal.date(byAdding: .month, value: 1, to: start)!
        return DateInterval(start: start, end: end)
    }
}

enum ReportFilter: CaseIterable, Equatable {
    case all
    case income
    case expense
}
