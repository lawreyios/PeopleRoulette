//
//  UsersHandler.swift
//  PeopleRoulette
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import ObjectMapper

protocol UsersDownloading {
    func getUsers(completion: @escaping ([User]?, String) -> Void)
}

protocol UsersRetrieving {
    func loadUsers() -> [User]?
}

class UsersHandler: UsersDownloading, UsersRetrieving {
    
    var apiHandler: APIRequesting!
    
    var realmSaver: ObjectSaving!
    var realmRetriever: ObjectRetrieving!
    var realmPurger: ObjectPurging!
    
    func getUsers(completion: @escaping ([User]?, String) -> Void) {
    }
    
    private func purgeUsers() {
        // to be implemented
    }
    
    private func saveUsers(_ users: [User]) {
        // to be implemented
    }
    
    func loadUsers() -> [User]? {
        // to be implemented
        return nil
    }
}
