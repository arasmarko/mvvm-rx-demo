//
//  Developer.swift
//  demo
//
//  Created by Marko Aras on 11/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

enum DemoError: Error {
    case modelMapping(model: String, attr: String)
}

enum DevTeam {
    case iOS
    case web
    case android
    
    init(name: String) throws {
        switch name {
        case "iOS":
            self = .iOS
        case "android":
            self = .android
        case "web":
            self = .web
        default:
//            self = .web
            throw DemoError.modelMapping(model: "Developer", attr: "team")
        }
    }
}

struct Developer: ImmutableMappable {
    let id: Int
    var name: String
    let team: DevTeam?
    
    init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        team = try DevTeam(name: try map.value("team"))
    }
    
    mutating func mapping(map: Map) {
        id >>> map["id"]
        name <- map["name"]
        team >>> map["team"]
    }
    
//    init(json: JSON) throws {
//        guard let id = json["id"].int else {
//            throw DemoError.modelMapping(model: "Developer", attr: "id")
//        }
//        guard let name = json["name"].string else {
//            throw DemoError.modelMapping(model: "Developer", attr: "name")
//        }
//        guard let teamString = json["team"].string else {
//            throw DemoError.modelMapping(model: "Developer", attr: "team")
//        }
//
//        self.id = id
//        self.name = name
//        self.team = DevTeam(name: json["team"].stringValue)
//    }
    
}
