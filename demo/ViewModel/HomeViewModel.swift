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

class HomeViewModel {
    var developers: Observable<[DevelopersSection]>!
    let isRefreshing = Variable(false)
    
    init(searchInput: Driver<String>, refreshControlDriver: Driver<String>) {
        let debouncedSearchInput = searchInput.asObservable()
            .skip(1)
            .distinctUntilChanged()
        
        let requestTriggers = Observable.merge(debouncedSearchInput, refreshControlDriver.asObservable())
        
        developers = requestTriggers
            .startWith("")
            .flatMapLatest({ [weak self] searchTerm -> Observable<[DevelopersSection]> in
                guard let `self` = self else {
                    return Observable.just([])
                }
                print("searchTerm", searchTerm)
                self.isRefreshing.value = true
                
                return DataService.shared.simulateFetchingDevelopersByName(name: searchTerm)
                    .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
                    .flatMapLatest { response -> Observable<[DevelopersSection]> in
                        let json = JSON(response)
                        var devs: [Developer] = []
                        for (_, dev) in json {
                            do {
                                devs.append( try Developer(json: dev))
                            } catch DemoError.modelMapping(let error) {
                                print("DemoError", error)
                            }
                        }
                        
                        let developersSection = DevelopersSection(header: "Developers", items: devs)
                        self.isRefreshing.value = false
                        return Observable.just([developersSection])
                }
                
                
            })
        
        
        
    }
    
}


