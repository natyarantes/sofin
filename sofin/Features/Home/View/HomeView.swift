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
                
                // Últimas transações
                Text("Últimas transações")
                    .font(.headline)
                    .padding(.top)
                
                VStack(spacing: 12) {
                    ForEach(viewModel.transactions, id: \.objectID) { transaction in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(transaction.title ?? "Sem título")
                                    .font(.headline)
                                Spacer()
                                if let date = transaction.date {
                                    Text(date.formatted(date: .abbreviated, time: .omitted))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            HStack {
                                Text("R$ \(transaction.amount, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(transaction.type == "income" ? .green : .red)
                                Spacer()
                                Text(transaction.type == "income" ? "Entrada" : "Saída")
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(transaction.type == "income" ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                    }
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            viewModel.refresh()
        }
    }
}
