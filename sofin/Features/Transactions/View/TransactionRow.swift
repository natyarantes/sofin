//
//  TransactionRow.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: TransactionModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(transaction.title)
                    .font(.headline)
                Spacer()
                Text(transaction.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            HStack {
                Text("R$ \(transaction.amount, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(transaction.financialType == .income ? .green : .red)

                Spacer()

                Text(transaction.financialType == .income ? "Entrada" : "Saída")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(transaction.financialType == .income ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 4)
    }
}

