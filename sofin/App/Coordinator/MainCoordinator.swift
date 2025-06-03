//
//  MainCoordinator.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
    override func start() {
        showHomeTab()
    }
    
    private func showHomeTab() {
        let tabCoordinator = MainTabCoordinator(navigationController: navigationController)
        tabCoordinator.start()
    }
}
