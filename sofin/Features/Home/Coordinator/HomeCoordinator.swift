//
//  HomeCoordinator.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import UIKit
import SwiftUI

final class HomeCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = HomeViewModel()
        let view = HomeView(viewModel: viewModel)
        
        let hostingController = UIHostingController(rootView: view)
        navigationController.setViewControllers([hostingController], animated: false)
    }
}
