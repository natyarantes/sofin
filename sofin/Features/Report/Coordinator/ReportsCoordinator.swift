//
//  ReportsCoordinator.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import UIKit
import SwiftUI

final class ReportsCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = ReportsViewModel()
        let view = ReportsView(/*viewModel: viewModel*/)
        let hosting = UIHostingController(rootView: view)
        
        navigationController.setViewControllers([hosting], animated: false )
    }
}
