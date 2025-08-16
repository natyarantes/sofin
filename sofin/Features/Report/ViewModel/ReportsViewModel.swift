//
//  ReportsViewModel.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import Foundation
import Combine

protocol CurrencyFormatting {
    
    func format(_ value: Double) -> String
}
struct DefaultCurrencyFormatter: CurrencyFormatting {
    func format(_ value: Double) -> String {
        let fmt = NumberFormatter()
        fmt.locale = Locale(identifier: "pt_BR")
        fmt.numberStyle = .currency
        return fmt.string(from: NSNumber(value: value)) ?? "R$ \(value)"
    }
}

protocol MonthFormatting {
    
    func format(_ date: Date) -> String
}
struct DefaultMonthFormatter: MonthFormatting {
    func format(_ date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "pt_BR")
        df.dateFormat = "MMMM 'de' yyyy"
        return df.string(from: date).capitalized
    }
}

enum ReportBuilder {
    static func makeSummary(from transactions: [Transaction], filter: ReportFilter) -> ReportSummary {
        var income: Double = 0
        var expense: Double = 0
        var perCategory: [String: Double] = [:]

        for t in transactions {
            switch t.type {
            case .income:
                if filter != .expense {
                    income += abs(t.amount)
                    if filter == .income {
                        perCategory[t.category, default: 0] += abs(t.amount)
                    }
                }
            case .expense:
                if filter != .income {
                    expense += abs(t.amount)
                    if filter != .income { // .expense ou .all → categorias de despesas
                        perCategory[t.category, default: 0] += abs(t.amount)
                    }
                }
            }
        }

        let catTotals = perCategory
            .map { CategoryTotal(category: $0.key, total: $0.value) }
            .sorted { $0.total > $1.total }

        return ReportSummary(incomeTotal: income, expenseTotal: expense, categoryTotals: catTotals)
    }
}


final class ReportsViewModel: ObservableObject {

    @Published private(set) var month: Date
    @Published private(set) var summary: ReportSummary = ReportSummary(incomeTotal: 0, expenseTotal: 0, categoryTotals: [])
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published var filter: ReportFilter = .all {
        didSet { rebuildSummary() }
    }

    private var monthTransactions: [Transaction] = []
    private let repo: TransactionsRepository
    private let currency: CurrencyFormatting
    private let monthFmt: MonthFormatting

    init(month: Date = Date(),
         repo: TransactionsRepository,
         currency: CurrencyFormatting = DefaultCurrencyFormatter(),
         monthFmt: MonthFormatting = DefaultMonthFormatter()) {
        self.month = month
        self.repo = repo
        self.currency = currency
        self.monthFmt = monthFmt
        load()
    }

    func load() {
        isLoading = true
        errorMessage = nil

        let interval = ReportMonth(monthDate: month).interval

        do {
            let items = try repo.fetchTransactions(in: interval)
            monthTransactions = items
            rebuildSummary()
        } catch {
            monthTransactions = []
            summary = ReportSummary(incomeTotal: 0, expenseTotal: 0, categoryTotals: [])
            errorMessage = "Erro ao carregar transações do mês."
        }

        isLoading = false
    }

    func nextMonth() {
        month = Calendar.current.date(byAdding: .month, value: 1, to: month) ?? month
        load()
    }

    func prevMonth() {
        month = Calendar.current.date(byAdding: .month, value: -1, to: month) ?? month
        load()
    }
    
    private func rebuildSummary() {
        summary = ReportBuilder.makeSummary(from: monthTransactions, filter: filter)
    }

    var monthTitle: String { monthFmt.format(month) }
    var incomeText: String { currency.format(summary.incomeTotal) }
    var expenseText: String { currency.format(summary.expenseTotal) }
    var balanceText: String { currency.format(summary.balance) }
    var isBalancePositive: Bool { summary.balance >= 0 }
}
