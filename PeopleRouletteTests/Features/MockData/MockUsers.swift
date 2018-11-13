//
//  MockUsers.swift
//  PeopleRouletteTests
//
//  Created by Lawrence Tan on 12/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

@testable import PeopleRoulette_starter

struct MockUsersJSON {
    static var data: [[String: Any?]?] {
        let JSONData: [[String: Any?]?] = [
            [
                "id": 1,
                "name": "Leanne Graham",
                "username": "Bret",
                "email": "Sincere@april.biz",
                "address": [
                    "street": "Kulas Light",
                    "suite": "Apt. 556",
                    "city": "Gwenborough",
                    "zipcode": "92998-3874",
                    "geo": [
                        "lat": "-37.3159",
                        "lng": "81.1496"
                    ]
                ],
                "phone": "1-770-736-8031 x56442",
                "website": "hildegard.org",
                "company": [
                    "name": "Romaguera-Crona",
                    "catchPhrase": "Multi-layered client-server neural-net",
                    "bs": "harness real-time e-markets"
                ]
            ]
        ]
        
        return JSONData
    }
}

struct MockUsers {
    static var data: [User] {
        let user1 = User()
        user1.name = "User 1"
        user1.email = "Email 1"
        user1.username = "Username 1"
        user1.id = 1
        
        let company1 = Company()
        company1.name = "Company 1"
        company1.catchPhrase = "Catch Phrase 1"
        
        user1.company = company1
        
        let user2 = User()
        user2.name = "User 2"
        user2.email = "Email 2"
        user2.id = 2
        
        let company2 = Company()
        company2.name = "Company 2"
        company2.catchPhrase = "Catch Phrase 2"
        
        user2.company = company2
        
        let user3 = User()
        user3.name = "User 3"
        user3.email = "Email 3"
        user3.id = 3
        
        let company3 = Company()
        company3.name = "Company 3"
        company3.catchPhrase = "Catch Phrase 3"
        
        user3.company = company3
        
        return [user1, user2, user3]
    }
}
