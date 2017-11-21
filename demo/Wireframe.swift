//
//  Wireframe.swift
//  demo
//
//  Created by Marko Aras on 11/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import UIKit

class Wireframe {
    static let shared = Wireframe()
    var window: UIWindow!
    
    func start(window: UIWindow) {
        self.window = window
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
    }
    
}
