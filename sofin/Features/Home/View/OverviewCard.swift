//
//  OverviewCard.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI

struct OverviewCard: View {
    
    var title: String
    var value: String
    var systemImage: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: systemImage)
                .foregroundColor(.accent)
                .font(.title2)
            Text(value)
                .font(.headline)
                .foregroundColor(.primary)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.backgroundCard)
        .cornerRadius(12)
    }
}

