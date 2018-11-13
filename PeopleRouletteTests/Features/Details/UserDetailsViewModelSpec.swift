//
//  UserDetailsViewModelSpec.swift
//  PeopleRouletteTests
//
//  Created by Lawrence Tan on 12/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Quick
import Nimble

@testable import PeopleRoulette_starter

class UserDetailsViewModelSpec: QuickSpec {
    override func spec() {
        let viewModel = UserDetailsViewModel()
        
        describe("Given user details") {
            beforeEach {
                viewModel.setupUserInfo(MockUsers.data.first!)
            }
            
            it("should display user info") {
                expect(viewModel.userInfo).to(equal("User 1\nUsername 1\nEmail 1"))
            }
        }
    }
}
