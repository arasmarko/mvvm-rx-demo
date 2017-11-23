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
    
    let tomo: [String: Any] = ["id": 1, "name": "Ivan", "team": "iOS"]
    let cuki: [String: Any] = ["id": 2, "name": "Ivana", "team": "android"]
    let kate: [String: Any] = ["id": 3, "name": "Ino", "team": "iOS"]
    let nike: [String: Any] = ["id": 4, "name": "Ivica", "team": "web"]
//    let nike1: [String: Any] = ["id": 4, "name": "Luka", "team": "web"]
//    let nike2: [String: Any] = ["id": 4, "name": "Luka", "team": "web"]
//    let nike3: [String: Any] = ["id": 4, "name": "Luka", "team": "web"]
//    let nike4: [String: Any] = ["id": 4, "name": "Luka", "team": "web"]
//    let nike5: [String: Any] = ["id": 4, "name": "Luka", "team": "web"]
//    let nike6: [String: Any] = ["id": 4, "name": "Luka", "team": "web"]
//    let nike7: [String: Any] = ["id": 4, "name": "Luka", "team": "web"]
    
    let test = PublishSubject<[[String: Any]]>()
    
    func simulateFetchingDevelopersByName(name: String) -> Observable<[[String: Any]]> {
        let allDevelopers = [tomo, cuki, kate, nike]//, nike1, nike2, nike3, nike4, nike5, nike6, nike7]
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
                    print("Search returning \(res.count) for \(name)")//, Thread.current)
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
