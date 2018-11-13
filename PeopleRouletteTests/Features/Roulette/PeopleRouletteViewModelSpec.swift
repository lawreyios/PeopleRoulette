//
//  PeopleRouletteViewModelSpec.swift
//  PeopleRouletteTests
//
//  Created by Lawrence Tan on 12/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Quick
import Nimble

@testable import PeopleRoulette_starter

class PeopleRouletteViewModelSpec: QuickSpec {
    override func spec() {
        let viewModel = PeopleRouletteViewModel()
        
        describe("Given a roulette") {
            // 1
            context("and downloading of users is successful") {
                beforeEach {
                    viewModel.usersDownloader = MockUsersDownloader(users: MockUsers.data, message: .empty)
                }
                
                it("should get the correct response") {
                    viewModel.getUsers(completion: { success, errorMessage in
                        expect(errorMessage).to(equal(.empty))
                        expect(success).to(beTrue())
                    })
                }
            }
            
            // 2
            context("and downloading of users is unsuccessful") {
                beforeEach {
                    viewModel.usersDownloader = MockUsersDownloader(users: [], message: AlertMessage.requestFailure)
                }
                
                it("should get the correct response") {
                    viewModel.getUsers(completion: { success, errorMessage in
                        expect(errorMessage).to(equal(AlertMessage.requestFailure))
                        expect(success).to(beFalse())
                    })
                }
            }
            
            // 3
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
                
                it("should populate picker data correctly") {
                    expect(viewModel.pickerData).to(equal([1, 2, 3]))
                }
            }
        }
    }
}

// 4
class MockUsersDownloader: UsersDownloading {
    var users: [User]?
    var message: String
    
    init(users: [User]?, message: String) {
        self.users = users
        self.message = message
    }
    
    func getUsers(completion: @escaping ([User]?, String) -> Void) {
        completion(users, message)
    }
}

// 5
class MockUsersRetriever: UsersRetrieving {
    func loadUsers() -> [User]? {
        return MockUsers.data
    }
}
