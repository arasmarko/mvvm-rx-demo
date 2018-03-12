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
    var counterState = 0
    var counter: Driver<String>!
    let disposeBag = DisposeBag()
    
    init(developer: Developer) {
        self.developer = developer
    }

    func setupIncreaseTaps(increaseCounterTaps: Observable<Void>) {
        counter = increaseCounterTaps
            .do(onNext: { [weak self] a in
                self?.counterState += 1
            })
            .flatMap { [weak self] _ -> Observable<String> in
                guard let `self` = self else {
                    return Observable.just("0")
                }
                return Observable.just("\(self.counterState)")
            }
            .asDriver(onErrorJustReturn: "0")
    }
    
}
