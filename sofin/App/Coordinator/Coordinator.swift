//
//  Coordinator.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    func start()
}
