
//
//  UsersListItemCellViewModel.swift
//  PeopleRoulette
//
//  Created by Lawrey on 13/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

protocol UsersListItemRepresenting {
    var name: String { get }
    var company: String { get }
}

class UsersListItemCellViewModel: UsersListItemRepresenting {
    
    var name = String.empty
    var company = String.empty
    
    init(user: User) {
        name = user.name
        company = user.company?.name ?? .empty
    }
}
