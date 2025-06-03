//
//  CoordinatorView.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI
import UIKit

struct CoordinatorView: UIViewControllerRepresentable {
    
    @Environment(\.managedObjectContext) var context
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
        return navigationController 
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
