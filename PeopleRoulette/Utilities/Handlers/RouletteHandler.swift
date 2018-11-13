//
//  RouletteHandler.swift
//  PeopleRoulette
//
//  Created by Lawrey on 10/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

protocol PeopleRouletting {
    // to be implemented
}

class RouletteHandler: PeopleRouletting {
    
    var usersRetriever: UsersRetrieving!
    
    func getRouletteResults(for numberOfPeople: Int) -> [User] {
        // to be implemented
        return []
    }    
}
