//
//  HomeViewModel.swift
//  demo
//
//  Created by Marko Aras on 11/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON
import ObjectMapper

class HomeViewModel: Transitionable {
    var navigationCoordinator: CoordinatorType?
    
    var developers: Observable<[DevelopersSection]>!
    let isRefreshing = Variable(false)
    
    let developerSubject = PublishSubject<Developer>()
    
    fileprivate let disposeBag = DisposeBag()
    
    init(searchInput: Driver<String>, refreshControlDriver: Driver<String>) {
        let debouncedSearchInput = searchInput.asObservable()
            .startWith("")
            .skip(1)
            .distinctUntilChanged()
//            .debounce(0.3, scheduler: ConcurrentDispatchQueueScheduler.init(qos: .background))
        
        let requestTriggers = Observable.merge(debouncedSearchInput, refreshControlDriver.asObservable())
        
        developers = requestTriggers
            .flatMapLatest({ [weak self] searchTerm -> Observable<[DevelopersSection]> in
                guard let `self` = self else {
                    return Observable.just([])
                }
                print("searchTerm", searchTerm)
                self.isRefreshing.value = true
                
                return DataService.shared.simulateFetchingDevelopersByName(name: searchTerm)
                    .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
                    .flatMapLatest { response -> Observable<[DevelopersSection]> in
                        var devs: [Developer] = []
                        
                        for (_, dev) in response.enumerated() {
                            do {
                                devs.append(try Developer(JSON: dev))
                            } catch DemoError.modelMapping(let error) {
                                print("DemoError", error)
                            } catch (let error) {
                                print("DemoError2", error)
                            }
                        }

                        
                        let developersSection = DevelopersSection(header: "Developers", items: devs)
                        self.isRefreshing.value = false
                        return Observable.just([developersSection])
                }
            })
        
        developerSubject
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else {
                    return
                }
                self.navigationCoordinator?.performTransition(transition: .showDeveloper($0))
            })
            .disposed(by: disposeBag)
    }
    
}


