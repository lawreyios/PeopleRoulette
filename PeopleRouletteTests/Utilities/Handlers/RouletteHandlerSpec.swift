//
//  RouletteHandlerSpec.swift
//  PeopleRouletteTests
//
//  Created by Lawrence Tan on 12/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Quick
import Nimble

@testable import PeopleRoulette_starter

class RouletteHandlerSpec: QuickSpec {
    override func spec() {
        let handler = RouletteHandler()
        handler.usersRetriever = MockUsersRetriever()
        
        describe("Given a roulette") {
            var randomUsers = [User]()
            
            // 1
            context("when getting a random user") {
                beforeEach {
                    randomUsers = handler.getRouletteResults(for: 1)
                }
                
                it("should return one user") {
                    expect(randomUsers.count).to(equal(1))
                }
            }
            
            // 2
            context("when getting more than 1 random user") {
                beforeEach {
                    randomUsers = handler.getRouletteResults(for: 2)
                }
                
                it("should return 2 users") {
                    expect(randomUsers.count).to(equal(2))
                }
            }
            
            // 3
            context("when getting all users") {
                beforeEach {
                    randomUsers = handler.getRouletteResults(for: 3)
                }
                
                it("should all 3 unique users") {
                    let firstUserExist = !randomUsers.filter({ $0.name == "User 1" }).isEmpty
                    let secondUserExist = !randomUsers.filter({ $0.name == "User 2" }).isEmpty
                    let thirdUserExist = !randomUsers.filter({ $0.name == "User 3" }).isEmpty
                    expect(firstUserExist).to(beTrue())
                    expect(secondUserExist).to(beTrue())
                    expect(thirdUserExist).to(beTrue())
                }
            }
        }
    }
}
