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
        return usersRetriever.loadUsers() ?? []
    }
    
    var maxCount: Int { return users.count }
    var minCount: Int { return 1 }
    
    var pickerData: [Int] {
        var tempData = [Int]()
        for number in minCount...maxCount {
            tempData.append(number)
        }
        return tempData
    }
    
    func getUsers(completion: @escaping ([User], String?) -> Void) {
        usersDownloader.getUsers { users, errorMessage in
            guard let users = users, !users.isEmpty else {
                completion([], errorMessage)
                return
            }
            
            completion(users, nil)
        }
    }
    
}
