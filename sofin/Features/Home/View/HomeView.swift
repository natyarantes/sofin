//
//  HomeView.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Sofin")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.accentColor)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Saldo Atual")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)

                        Text("R$ \(viewModel.totalBalance, specifier: "%.2f")")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(viewModel.totalBalance >= 0 ? .green : .red)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("BackgroundCardColor"))
                    .cornerRadius(12)

                    Text("Visão Geral")
                        .font(.headline)

                    HStack(spacing: 12) {
                        OverviewCard(title: "Entradas",
                                     value: "R$ \(viewModel.incomeTotal)",
                                     systemImage: "arrow.down.circle.fill")

                        OverviewCard(title: "Saídas",
                                     value: "R$ \(viewModel.expenseTotal)",
                                     systemImage: "arrow.up.circle.fill")

                        OverviewCard(title: "Saldo",
                                     value: "R$ \(viewModel.totalBalance)",
                                     systemImage: "banknote.fill")
                    }

                    Text("Últimas transações")
                        .font(.headline)
                        .padding(.top)

                    List(viewModel.transactions) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                    .listStyle(.plain)
                    .frame(height: CGFloat(viewModel.transactions.count) * 80)
                }
                .padding()
            }
            .onAppear {
                viewModel.refresh()
            }
            .navigationBarHidden(true)
        }
    }
}

