
//
//  AppCoordinator.swift
//  demo
//
//  Created by Marko Aras on 17/01/2018.
//  Copyright © 2018 MITURF. All rights reserved.
//

import UIKit

protocol Transitionable: class {
    weak var navigationCoordinator: CoordinatorType? { get }
}

protocol CoordinatorType: class {
    var baseController: UIViewController { get }
    func performTransition(transition: Transition)
}

enum Transition {
    case showDeveloper(Developer)
}

class AppCoordinator: CoordinatorType {
    var baseController: UIViewController
    
    init() {
        let homeVC = HomeViewController()
        self.baseController = UINavigationController(rootViewController: homeVC)
        homeVC.homeViewModel.navigationCoordinator = self
    }
    
    func performTransition(transition: Transition) {
        switch transition {
        case .showDeveloper(let developer):
            if let baseNav = baseController as? UINavigationController {
                let devVM = DeveloperViewModel(developer: developer)
                let devVC = DeveloperViewController(developerViewModel: devVM)
                baseNav.pushViewController(devVC, animated: true)
            }
        }
    }
}

