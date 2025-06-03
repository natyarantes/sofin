//
//  AddTransactionCoordinator.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import UIKit
import SwiftUI

final class AddTransactionCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = AddTransactionViewModel()
        let view = AddTransactionView(viewModel: viewModel)
        let hosting = UIHostingController(rootView: view)
        navigationController.present(hosting, animated: true)
    }
}
