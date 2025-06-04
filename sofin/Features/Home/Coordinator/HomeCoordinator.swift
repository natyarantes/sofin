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
        let context = PersistenceController.shared.container.viewContext
        let viewModel = HomeViewModel(context: context)
        let homeView = HomeView(viewModel: viewModel)
        
        let hostingController = UIHostingController(rootView: homeView)
        navigationController.pushViewController(hostingController, animated: false)
    }
}
