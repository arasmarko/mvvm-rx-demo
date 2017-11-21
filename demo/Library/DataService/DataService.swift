//
//  DataService.swift
//  demo
//
//  Created by Marko Aras on 11/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class DataService {
    static let shared = DataService()
    
    let tomo: [String: Any] = ["id": 1, "name": "Cuki", "team": "iOS"]
    let cuki: [String: Any] = ["id": 2, "name": "Culuma", "team": "android"]
    let kate: [String: Any] = ["id": 3, "name": "Curle", "team": "iOS"]
    let nike: [String: Any] = ["id": 4, "name": "Smuki", "team": "web"]
    
    let test = PublishSubject<[[String: Any]]>()
    
    func simulateFetchingDevelopersByName(name: String) -> Observable<[[String: Any]]> {//, rand: Double
        let res = [tomo, cuki, kate, nike].filter({ dev in
            guard !name.isEmpty else {
                return true
            }
            if let d = dev["name"] as? String {
                return d.lowercased().range(of: name.lowercased()) != nil
            }
            return false
        })
        
        let rand = Double(arc4random_uniform(6) + 1)
        
        return Observable
            .create({ [unowned self] observer in
                self.asyncGet(rand: rand, completion: {
                    print("Search returning \(res.count) for \(name)", Thread.current)
                    return observer.onNext((res))
                })
                return Disposables.create()
            })
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
    }
    
    
    
    func asyncGet(rand: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + rand, execute: {
            completion()
        })
        
    }
    
}
