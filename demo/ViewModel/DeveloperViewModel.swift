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

class DeveloperViewModel {
    let developer: Developer
    
    let resourceMemoryLeak = Variable(0)
    
    let disposeBag = DisposeBag()

    init(developer: Developer) {
        self.developer = developer
        self.resourceMemoryLeak.value = 10
    }
    
}
