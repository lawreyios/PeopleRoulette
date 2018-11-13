//
//  PeopleRouletteViewModelSpec.swift
//  PeopleRouletteTests
//
//  Created by Lawrence Tan on 12/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import PeopleRoulette

class PeopleRouletteViewModelSpec: QuickSpec {
    override func spec() {
        let viewModel = PeopleRouletteViewModel()
        
        describe("Given a roulette") {
            context("and downloading of users is successful") {
                beforeEach {
                    viewModel.usersDownloader = MockUsersDownloader(users: MockUsers.data, message: nil)
                }
                
                it("should get the correct response") {
                    waitUntil(timeout: 3.0) { done in
                        viewModel.getUsers(completion: { users, errorMessage in
                            expect(errorMessage).to(beNil())
                            expect(users.isEmpty).toNot(beTrue())
                        })
                        done()
                    }
                }
            }
            
            context("and downloading of users is unsuccessful") {
                beforeEach {
                    viewModel.usersDownloader = MockUsersDownloader(users: [], message: AlertMessage.requestFailure)
                }
                
                it("should get the correct response") {
                    waitUntil(timeout: 3.0) { done in
                        viewModel.getUsers(completion: { users, errorMessage in
                            expect(errorMessage).to(equal(AlertMessage.requestFailure))
                            expect(users.isEmpty).to(beTrue())
                        })
                        done()
                    }
                }
            }
            
            context("and there are 3 available users") {
                beforeEach {
                    viewModel.usersRetriever = MockUsersRetriever()
                }
                
                it("should allow selection of minimum 1 person") {
                    expect(viewModel.minCount).to(equal(1))
                }
                
                it("should allow selection of maximum 3 people") {
                    expect(viewModel.maxCount).to(equal(3))
                }
            }
        }
    }
}

class MockUsersDownloader: UsersDownloading {
    
    var users: [User]?
    var message: String?
    
    init(users: [User]?, message: String?) {
        self.users = users
        self.message = message
    }
    
    func getUsers(completion: @escaping ([User]?, String?) -> Void) {
        completion(users, message)
    }
}

class MockUsersRetriever: UsersRetrieving {
    func loadUsers() -> [User]? {
        return MockUsers.data
    }
}
