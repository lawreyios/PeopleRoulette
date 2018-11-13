//
//  RouletteHandler.swift
//  PeopleRoulette
//
//  Created by Lawrey on 10/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

// 1
protocol PeopleRouletting {
    func getRouletteResults(for numberOfPeople: Int) -> [User]
}

class RouletteHandler: PeopleRouletting {
    
    var usersRetriever: UsersRetrieving!
    
    // 1
    func getRouletteResults(for numberOfPeople: Int) -> [User] {
        guard let users = usersRetriever.loadUsers() else {
            return []
        }
        
        return users.sample(UInt(numberOfPeople))
    }    
}
