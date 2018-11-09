//
//  RealmHandler.swift
//  PeopleRoulette
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import RealmSwift

protocol ObjectSaving {
    func saveObjects(_ items: [Object])
}

protocol ObjectRetrieving {
    func getObjects<T: Object>(for type: T.Type) -> [Object]
}

protocol ObjectPurging {
    func deleteObjects<T: Object>(for type: T.Type, cascade: Bool)
}

class RealmHandler: ObjectSaving, ObjectRetrieving, ObjectPurging {
    
    var realm: Realm!
    
    init() {
        do {
            realm = try Realm()
            
            setDataEncryption()
            verifyDataEncryption()
        } catch let error {
            print("Initializing Realm Database with error: \(error)")
        }
    }
    
    // For unit testing
    init(realm: Realm) {
        self.realm = realm
    }
    
    private func setDataEncryption() {
        do {
            guard let folderPath = realm.configuration.fileURL?.deletingLastPathComponent().path else {
                print("Error in getting realm file's parent path")
                return
            }
            
            try FileManager.default.setAttributes([FileAttributeKey.protectionKey: FileProtectionType.complete], ofItemAtPath: folderPath)
            
            guard let filePath = realm.configuration.fileURL?.path else {
                print("Error in getting realm file's path")
                return
            }
            
            try FileManager.default.setAttributes([FileAttributeKey.protectionKey: FileProtectionType.complete], ofItemAtPath: filePath)
        } catch let error {
            print("Encrypting data failed with error: \(error)")
        }
    }
    
    private func verifyDataEncryption() {
        if let folderPath = realm.configuration.fileURL?.deletingLastPathComponent().path,
            let attributes = try? FileManager.default.attributesOfItem(atPath: folderPath),
            let protectionAttribute = attributes[FileAttributeKey.protectionKey] as? String {
            
            print("Protection attribute \(protectionAttribute) set on \(folderPath)")
        } else {
            print("Not able to verify data encryption setup on a directory where Realm file is stored. Ignore if running in a simulator.")
        }
        
        if let filePath = realm.configuration.fileURL?.path,
            let attributes = try? FileManager.default.attributesOfItem(atPath: filePath),
            let protectionAttribute = attributes[FileAttributeKey.protectionKey] as? String {
            
            print("Protection attribute \(protectionAttribute) set on \(filePath)")
        } else {
            print("Not able to verify data encryption setup on Realm file. Ignore if running in a simulator.")
        }
    }
    
    func saveObjects(_ items: [Object]) {
        guard let realm = realm else {
            print("Error loading Realm")
            return
        }
        
        do {
            try realm.write {
                realm.add(items)
            }
        } catch let error {
            print("Save object \(items) with error: \(error).")
        }
    }
    
    func getObjects<T: Object>(for type: T.Type) -> [Object] {
        guard let realm = realm else {
            print("Error loading Realm")
            return []
        }
        
        let items = realm.objects(type)
        return Array(items)
    }
    
    func deleteObjects<T: Object>(for type: T.Type, cascade: Bool) {
        guard let realm = realm else {
            print("Error loading Realm")
            return
        }
        
        let items = realm.objects(type)
        
        guard !items.isEmpty else {
            print("No objects found for type: \(type)")
            return
        }
        
        do {
            try realm.write { realm.delete(items) }
        } catch let error {
            print("Delete objects for type - \(type) with error: \(error).")
        }
    }
}
