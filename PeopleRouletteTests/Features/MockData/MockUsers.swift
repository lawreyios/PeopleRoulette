//
//  MockUsers.swift
//  PeopleRouletteTests
//
//  Created by Lawrence Tan on 12/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

@testable import PeopleRoulette

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
