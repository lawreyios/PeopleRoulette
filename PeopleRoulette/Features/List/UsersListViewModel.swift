//
//  UsersListViewModel.swift
//  PeopleRoulette
//
//  Created by Lawrence Tan on 9/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class UsersListViewModel {
    
    var peopleRoulette: PeopleRouletting!
    var numberOfRows: Int { return selectedPeople.count }
    
    private var selectedPeople = [User]()
    private var cellViewModels = [UsersListItemRepresenting]()
    
    func setup(with numberOfPeople: Int) {
        selectedPeople = peopleRoulette.getRouletteResults(for: numberOfPeople)
        
        cellViewModels.removeAll()
        
        for person in selectedPeople {
            cellViewModels.append(UsersListItemCellViewModel(user: person))
        }
    }
    
    func getUser(for row: Int) -> User { return selectedPeople[row] }
    func getCellViewModel(for row: Int) -> UsersListItemRepresenting { return cellViewModels[row] }
}
