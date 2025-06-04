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
        GeometryReader { geometry in
            ZStack {
                TabView(selection: $selectedTab) {
                    UIViewControllerWrapper(controller: homeNav)
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        .tag(0)

                    UIViewControllerWrapper(controller: reportsNav)
                        .tabItem {
                            Label("Relatórios", systemImage: "chart.bar.fill")
                        }
                        .tag(1)
                }

                Button(action: {
                    onAddTap()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: 64, height: 64)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height - 38)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
