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
        VStack{
            Text("Welcome to Sofin!")
                .font(.largeTitle)
                .padding()
            
            Text("Home Screen")
                .foregroundColor(.gray)
        }
    }
}
