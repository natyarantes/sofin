//
//  ReportsCoordinator.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import UIKit
import SwiftUI
import CoreData

final class ReportsCoordinator: BaseCoordinator {

    private let context: NSManagedObjectContext

    init(navigationController: UINavigationController,
         context: NSManagedObjectContext) {
        self.context = context
        super.init(navigationController: navigationController)
    }

    override func start() {
        let repo = CoreDataTransactionsRepository(context: context)
        let viewModel = ReportsViewModel(repo: repo)
        let view = ReportsView(viewModel: viewModel)
        let hosting = UIHostingController(rootView: view)
        hosting.title = "Relatórios"

        navigationController.setViewControllers([hosting], animated: false)
    }

    func push() {
        let repo = CoreDataTransactionsRepository(context: context)
        let viewModel = ReportsViewModel(repo: repo)
        let hosting = UIHostingController(rootView: ReportsView(viewModel: viewModel))
        hosting.title = "Relatórios"
        navigationController.pushViewController(hosting, animated: true)
    }
}

