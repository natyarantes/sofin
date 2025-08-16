//
//  ReportsView.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI

struct ReportsView: View {
    @ObservedObject var viewModel: ReportsViewModel
    
    private func label(for filter: ReportFilter) -> String {
        switch filter {
        case .all: return "Todas"
        case .income: return "Receitas"
        case .expense: return "Despesas"
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            header
            picker
            totals
            content
        }
        .padding(.horizontal, 16)
        .navigationTitle("Relatórios")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        HStack {
            Button("◀︎") { viewModel.prevMonth() }
            Spacer()
            Text(viewModel.monthTitle)
                .font(.title3).fontWeight(.semibold)
            Spacer()
            Button("▶︎") { viewModel.nextMonth() }
        }
        .padding(.top, 8)
    }
    
    private var picker: some View {
        Picker("Filtro", selection: $viewModel.filter) {
            Text(label(for: .all)).tag(ReportFilter.all)
            Text(label(for: .income)).tag(ReportFilter.income)
            Text(label(for: .expense)).tag(ReportFilter.expense)
        }
        .pickerStyle(.segmented)
    }

    private var totals: some View {
        VStack(spacing: 6) {
            HStack(spacing: 12) {
                Text("Receitas: \(viewModel.incomeText)")
                Text("•")
                Text("Despesas: \(viewModel.expenseText)")
            }
            Text("Saldo do mês: \(viewModel.balanceText)")
                .foregroundColor(viewModel.isBalancePositive ? .primary : .red)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
    }

    private var content: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Carregando…").frame(maxWidth: .infinity, alignment: .center)
            } else if let msg = viewModel.errorMessage {
                Text(msg).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .center)
            } else if viewModel.summary.categoryTotals.isEmpty {
                Text("Sem despesas neste mês.")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                List(viewModel.summary.categoryTotals) { item in
                    HStack {
                        Text(item.category)
                        Spacer()
                        Text(item.total, format: .currency(code: "BRL"))
                            .foregroundColor(.secondary)
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
    }
}
