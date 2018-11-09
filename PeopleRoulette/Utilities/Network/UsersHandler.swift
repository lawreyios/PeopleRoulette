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
    func getUsers(completion: @escaping ([User]?, String?) -> Void)
}

protocol UsersRetrieving {
    func loadUsers() -> [User]?
}


class UsersHandler: UsersDownloading, UsersRetrieving {
    
    var apiHandler: APIRequesting!
    
    var realmSaver: ObjectSaving!
    var realmRetriever: ObjectRetrieving!
    var realmPurger: ObjectPurging!
    
    func getUsers(completion: @escaping ([User]?, String?) -> Void) {
        let request = APIRequest(url: URL.baseURL + EndPoint.users, method: .get)
        apiHandler.sendRequest(request) { success, data, errorMessage in
            guard success else {
                completion(nil, AlertMessage.requestFailure)
                return
            }
            
            guard let users = Mapper<User>().mapArray(JSONObject: data) else {
                completion(nil, AlertMessage.requestFailure)
                return
            }
            
            self.purgeUsers()
            self.saveUsers(users)
            
            completion(users, nil)
        }
    }
    
    private func purgeUsers() {
        realmPurger.deleteObjects(for: User.self, cascade: true)
    }
    
    private func saveUsers(_ users: [User]) {
        realmSaver.saveObjects(users)
    }
    
    func loadUsers() -> [User]? {
        return realmRetriever.getObjects(for: User.self) as? [User]
    }
}
