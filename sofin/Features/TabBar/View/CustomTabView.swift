//
//  CustomTabView.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI
import UIKit

struct CustomTabView: View {
    
    let homeNav: UINavigationController
    let reportsNav: UINavigationController
    let onAddTap: () -> Void
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            UIViewControllerWrapper(controller: homeNav)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            Color.clear
                .tabItem {
                    Image(systemName: "plus.cicle.fill")
                        .font(.system(size: 28))
                }
                .tag(1)
            UIViewControllerWrapper(controller: reportsNav)
                .tabItem {
                    Label("Relatórios", systemImage: "chart.bar.fill")
                }
                .tag(2)
        }
        .onChange(of: selectedTab) { newValue in
                if newValue == 1 {
                onAddTap()
                    selectedTab = 0
            }
        }
    }
}
