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
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
    }
}
