//
//  Developer.swift
//  demo
//
//  Created by Marko Aras on 11/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import Foundation
import SwiftyJSON

enum DemoError: Error {
    case modelMapping(model: String, attr: String)
}

enum DevTeam {
    case iOS
    case web
    case android
    
    init(name: String) {
        switch name {
        case "iOS":
            self = .iOS
        case "android":
            self = .android
        default:
            self = .web
        }
    }
}

struct Developer {
    let id: Int
    let name: String
    let team: DevTeam
    
    init(json: JSON) throws {
        guard let id = json["id"].int else {
            throw DemoError.modelMapping(model: "Developer", attr: "id")
        }
        guard let name = json["name"].string else {
            throw DemoError.modelMapping(model: "Developer", attr: "name")
        }
        guard let teamString = json["team"].string else {
            throw DemoError.modelMapping(model: "Developer", attr: "team")
        }
        
        self.id = id
        self.name = name
        self.team = DevTeam(name: teamString)
    }
    
}
