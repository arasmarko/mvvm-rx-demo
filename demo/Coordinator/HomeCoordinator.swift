//
//  HomeCoordinator.swift
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

class HomeCoordinator: CoordinatorType {
    var baseController: UIViewController
    
    init(developer: Developer) {
        let viewModel = DeveloperViewModel(developer: developer)
        self.baseController = UINavigationController(rootViewController: MainViewController(viewModel: viewModel))
        viewModel.navigationCoordinator = self
    }
    
    func performTransition(transition: Transition) {
        switch transition {
        case .showRepository(let repository):
            UIApplication.shared.open(URL(string: repository.url)!, options: [:], completionHandler: nil)
        }
    }
}

