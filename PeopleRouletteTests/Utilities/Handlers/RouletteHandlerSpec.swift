//
//  RouletteHandlerSpec.swift
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

class RouletteHandlerSpec: QuickSpec {
    override func spec() {
        let handler = RouletteHandler()
        handler.usersRetriever = MockUsersRetriever()
        
        describe("Given a roulette") {
            var randomUsers = [User]()
            
            context("when getting a random user") {
                beforeEach {
                    randomUsers = handler.getRouletteResults(for: 1)
                }
                
                it("should return one user") {
                    expect(randomUsers.count).to(equal(1))
                }
            }
            
            context("when getting more than 1 random user") {
                beforeEach {
                    randomUsers = handler.getRouletteResults(for: 2)
                }
                
                it("should return 2 user") {
                    expect(randomUsers.count).to(equal(2))
                }
            }
        }
    }
}
