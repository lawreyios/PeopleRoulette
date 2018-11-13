//
//  PeopleRouletteViewModel.swift
//  PeopleRoulette
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

class PeopleRouletteViewModel {
    
    var usersDownloader: UsersDownloading!
    var usersRetriever: UsersRetrieving!
    
    // 1
    private var users: [User] {
        return usersRetriever.loadUsers() ?? []
    }
    
    // 2
    var maxCount: Int { return users.count }
    var minCount: Int { return 1 }
    
    var pickerData: [Int] {
        var tempData = [Int]()
        for number in minCount...maxCount {
            tempData.append(number)
        }
        return tempData
    }
    
    // 3
    func getUsers(completion: @escaping (Bool, String) -> Void) {
        usersDownloader.getUsers { users, errorMessage in
            guard let users = users, !users.isEmpty else {
                completion(false, errorMessage)
                return
            }
            
            completion(true, .empty)
        }
    }
}
