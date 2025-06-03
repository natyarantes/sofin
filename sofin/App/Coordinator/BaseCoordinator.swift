//
//  BaseCoordinator.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import UIKit

class BaseCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var rootViewController: UIViewController {
        navigationController
    }
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("Subclasses must implement start()")
    }
}
