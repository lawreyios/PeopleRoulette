//
//  UsersListItemCellViewModelSpec.swift
//  PeopleRouletteTests
//
//  Created by Lawrence Tan on 13/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Quick
import Nimble

@testable import PeopleRoulette_starter

class UsersListItemCellViewModelSpec: QuickSpec {
    override func spec() {
        let cellViewModel = UsersListItemCellViewModel(user: MockUsers.data.first!)
        
        describe("Given a user list item") {
            it("should display user's name") {
                expect(cellViewModel.name).to(equal("User 1"))
            }
            
            it("should display user's company") {
                expect(cellViewModel.company).to(equal("Company 1"))
            }
        }
    }
}
