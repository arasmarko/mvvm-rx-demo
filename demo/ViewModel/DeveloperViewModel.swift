//
//  DeveloperViewModel.swift
//  demo
//
//  Created by Marko Aras on 12/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

enum SimulatedError: Error {
    case somethingWrong(String)
}

class DeveloperViewModel {
    var developer: Developer!
    
    let disposeBag = DisposeBag()
    
    deinit {
        print("deinit DeveloperViewModel")
    }
    
    init(developer: Developer) {
        self.developer = developer
    }
    
}
