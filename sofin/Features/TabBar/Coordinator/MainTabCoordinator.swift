//
//  MainTabCoordinator.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import UIKit
import SwiftUI

final class MainTabCoordinator: BaseCoordinator {
    
    override func start() {
        let homeNav = UINavigationController()
        let reportsNav = UINavigationController()
        
        let homeCoordinator = HomeCoordinator(navigationController: homeNav)
        let reportsCoordinator = ReportsCoordinator(navigationController: reportsNav)
        
        homeCoordinator.start()
        reportsCoordinator.start()
        
        let tabView = CustomTabView(homeNav: homeNav,
                                    reportsNav: reportsNav,
                                    onAddTap: {
            let addTransactionCoordinator = AddTransactionCoordinator(navigationController: homeNav)
            addTransactionCoordinator.start()
        })
        
        let hostingController = UIHostingController(rootView: tabView)
        navigationController.pushViewController(hostingController, animated: false)
    }
}
