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
    
    let dev1: [String: Any] = ["id": 1, "name": "John", "team": "iOS"]
    let dev2: [String: Any] = ["id": 2, "name": "Johnny", "team": "android"]
    let dev3: [String: Any] = ["id": 3, "name": "Johan", "team": "iOS"]
    let dev4: [String: Any] = ["id": 4, "name": "Jacob", "team": "web"]
    
    let test = PublishSubject<[[String: Any]]>()
    
    func simulateFetchingDevelopersByName(name: String) -> Observable<[[String: Any]]> {
        let allDevelopers = [dev1, dev2, dev3, dev4]
        let res = allDevelopers.filter({ dev in
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
                    print("Search returning \(res) for \(name)")
                    return observer.onNext((res))
                })
                return Disposables.create()
            })
    }
    
    
    
    func asyncGet(rand: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + rand, execute: {
            completion()
        })
        
    }
    
}
