//
//  UserDetailsViewModel.swift
//  PeopleRoulette
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class UserDetailsViewModel {
    
    private var selectedUser: User!
    
    var userInfo: String {
        // to be implemented
        return .empty
    }
    
    func setupUserInfo(_ user: User) {
        self.selectedUser = user
    }
}
