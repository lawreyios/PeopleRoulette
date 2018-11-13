//
//  PeopleRouletteViewModel.swift
//  PeopleRoulette
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class PeopleRouletteViewModel {
    
    var usersDownloader: UsersDownloading!
    var usersRetriever: UsersRetrieving!
    
    var users: [User] {
        // to be implemented
        return []
    }
    
    var maxCount: Int { return 3 }
    var minCount: Int { return 1 }
    
    var pickerData: [Int] {
        var tempData = [Int]()
        for number in minCount...maxCount {
            tempData.append(number)
        }
        return tempData
    }
    
    func getUsers(completion: @escaping ([User], String?) -> Void) {
        // to be implemented
    }
    
}
