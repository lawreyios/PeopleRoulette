//
//  User.swift
//  PeopleRoulette
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class User: Object, Mappable {
    
    @objc dynamic var id = Int.zero
    @objc dynamic var username = String.empty
    @objc dynamic var name = String.empty
    @objc dynamic var email = String.empty
    @objc dynamic var company: Company?

    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        username <- map ["username"]
        email <- map["email"]
        company <- map["company"]
    }
}

class Company: Object, Mappable {
    
    @objc dynamic var name = String.empty
    @objc dynamic var catchPhrase = String.empty
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        catchPhrase <- map["catchPhrase"]
    }
}
