//
//  MockRealmHandlers.swift
//  PeopleRoulette-starter
//
//  Created by Lawrence Tan on 13/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import RealmSwift

class MockUsersPurger: ObjectPurging {
    func deleteObjects<T>(for type: T.Type, cascade: Bool) where T : Object {}
}

class MockUsersSaver: ObjectSaving {
    func saveObject(_ item: Object) {}
    func saveObjects(_ items: [Object]) {}
}
