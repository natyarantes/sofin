//
//  TransactionRow.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI

struct TransactionRow: View {
    let title: String
    let value: String
    let isExpense: Bool
    let date: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
                Text(date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Text(value)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(isExpense ? .red : .green)
        }
        .padding()
        .background(.backgroundCard)
        .cornerRadius(12)
    }
}
