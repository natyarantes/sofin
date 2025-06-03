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
        VStack(alignment: .leading, spacing: 24) {
            Text("Sofin")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.accentColor)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Saldo Atual")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                
                Text("R$ 5.200,00")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.accentColor)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("BackgroundCardColor"))
            .cornerRadius(12)
            
            Text("Visão Geral")
                .font(.headline)
            
            HStack(spacing: 12) {
                OverviewCard(title: "Entradas", value: "R$ 3.200", systemImage: "arrow.down.circle.fill")
                OverviewCard(title: "Saídas", value: "R$ 1.800", systemImage: "arrow.up.circle.fill")
                OverviewCard(title: "Saldo", value: "R$ 1.400", systemImage: "banknote.fill")
            }
            
            Text("Últimas transações")
                .font(.headline)
                .padding(.top)
            VStack(spacing: 12) {
                TransactionRow(title: "Alimentação", value: "-R$ 50,00", isExpense: true, date: "01/06/2025")
                TransactionRow(title: "Salário", value: "+R$ 3.000,00", isExpense: false, date: "30/05/2025")
                TransactionRow(title: "Transporte", value: "-R$ 20,00", isExpense: true, date: "29/05/2025")
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
