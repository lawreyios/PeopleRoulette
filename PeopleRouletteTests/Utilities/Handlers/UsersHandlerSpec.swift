//
//  UsersHandlerSpec.swift
//  PeopleRoulette-starter
//
//  Created by Lawrence Tan on 13/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import PeopleRoulette_starter

class UsersHandlerSpec: QuickSpec {
    override func spec() {
        
        // 1
        let usersHandler = UsersHandler()
        usersHandler.realmPurger = MockUsersPurger()
        usersHandler.realmSaver = MockUsersSaver()
        
        // 2
        describe("Given a users list url") {
            beforeEach {
                usersHandler.apiHandler = MockAPIHandler(success: true, data: MockUsersJSON.data, errorMessage: .empty)
            }
            
            context("and a network call is established") {
                it("should get users list") {
                    // 3
                    usersHandler.getUsers(completion: { users, errorMessage in
                        expect(users!.count).to(equal(1))
                        expect(users!.first!.name).to(equal("Leanne Graham"))
                        expect(errorMessage).to(equal(String.empty))
                    })
                }
            }
            
            context("and a network call fails") {
                beforeEach {
                    usersHandler.apiHandler = MockAPIHandler(success: false, data: nil, errorMessage: AlertMessage.requestFailure)
                }
                
                it("should not get users list") {
                    usersHandler.getUsers(completion: { users, errorMessage in
                        expect(users).to(beNil())
                        expect(errorMessage).to(equal("Request Failure"))
                    })
                }
            }
        }
    }
}

class MockAPIHandler: APIRequesting {
    
    var success = false
    var data: Any?
    var errorMessage = String.empty
    
    init(success: Bool, data: Any?, errorMessage: String) {
        self.success = success
        self.data = data
        self.errorMessage = errorMessage
    }
    
    func sendRequest(_ request: APIRequest, completion: @escaping (Bool, Any?, String) -> Void) {
        completion(success, data, errorMessage)
    }
}
