//
//  UIViewControllerWrapper.swift
//  sofin
//
//  Created by Natália Arantes on 03/06/25.
//

import SwiftUI
import UIKit

struct UIViewControllerWrapper: UIViewControllerRepresentable {
    
    let controller: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
