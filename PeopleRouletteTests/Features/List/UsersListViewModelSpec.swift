//
//  UsersListViewModelSpec.swift
//  PeopleRouletteTests
//
//  Created by Lawrence Tan on 12/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject
import SwinjectStoryboard

@testable import PeopleRoulette

class UsersListViewModelSpec: QuickSpec {
    override func spec() {
        let viewModel = UsersListViewModel()
        viewModel.peopleRoulette = MockPeopleRoulette()
        
        describe("Given Roulette results") {
            beforeEach {
                viewModel.setup(with: 3)
            }
            
            it("should show the correct number of selected people in the list") {
                expect(viewModel.numberOfRows).to(equal(3))
            }
            
            it("should show the correct person in each row") {
                expect(viewModel.getUser(for: 0).name).to(equal("User 1"))
                expect(viewModel.getUser(for: 0).company?.name).to(equal("Company 1"))
            }
        }
    }
}

class MockPeopleRoulette: PeopleRouletting {
    func getRouletteResults(for numberOfPeople: Int) -> [User] {
        return MockUsers.data
    }
}
