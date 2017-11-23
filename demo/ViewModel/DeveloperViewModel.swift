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
    var counter: Observable<Int>! // 1
//    var counter: Driver<String>! // 2
    
    let disposeBag = DisposeBag()
    
    deinit {
        print("deinit DeveloperViewModel")
    }
    
    init(developer: Developer) {
        self.developer = developer
    }
    
    // 1
    func setupIncreaseTaps(increaseCounterTaps: Observable<Void>) {
        counter = increaseCounterTaps
//            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))// Driver example
            .flatMapLatest({ [weak self] _ -> Observable<Int> in
                guard let `self` = self else {
                    return Observable.just(0)
                }
                self.counterState += 1
                return Observable.just(self.counterState)
            })
    }
    
//    // 1.1 Error handling
//    func setupIncreaseTaps(increaseCounterTaps: Observable<Void>) {
//        counter = increaseCounterTaps
//            .flatMapLatest({ [weak self] _ -> Observable<Int> in
//                guard let `self` = self else {
//                    return Observable.just(0)
//                }
//                self.counterState += 1
//
//                if self.counterState == 3 {
//                    let simulatedError = SimulatedError.somethingWrong("error")
//                    return Observable.error(simulatedError)
//                }
//
//                return Observable.just(self.counterState)
//
//            })
//            .catchError({ (err) -> Observable<Int> in
//                return Observable.just(0)
//            })
//
//    }
    
//     2
//    func setupIncreaseTaps(increaseCounterTaps: Observable<Void>) {
//        counter = increaseCounterTaps
//            .flatMapLatest { [weak self] _ -> Observable<String> in
//                guard let `self` = self else {
//                    return Observable.just("0")
//                }
//                self.counterState += 1
//                return Observable.just("\(self.counterState)")
//            }
//            .asDriver(onErrorJustReturn: "0")
//    }
    
}
