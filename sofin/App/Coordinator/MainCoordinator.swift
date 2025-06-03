//
//  MainCoordinator.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
    override func start() {
        showHome()
    }
    
    private func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
        append(coordinator: homeCoordinator)
    }
}
