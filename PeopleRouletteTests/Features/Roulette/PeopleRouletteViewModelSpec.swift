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
        // to be implemented
    }
}

class MockUsersDownloader: UsersDownloading {
    func getUsers(completion: @escaping ([User]?, String?) -> Void) {
        // to be implemented
    }
}

class MockUsersRetriever: UsersRetrieving {
    func loadUsers() -> [User]? {
        // to be implemented
        return nil
    }
}
