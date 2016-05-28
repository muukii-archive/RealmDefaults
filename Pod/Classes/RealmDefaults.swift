// RealmDefaults.swift
//
// Copyright (c) 2015 muukii
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import RealmSwift

#if os(iOS)
    private let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
#elseif os(OSX)
    private let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
#endif

public protocol RealmDefaultsType: class {
    
    static func write(@noescape block: (Self) throws -> Void) throws
    static func configuration() -> RealmSwift.Realm.Configuration
}

extension RealmDefaultsType where Self: RealmDefaults {
    
    public static func replace(object: Self) throws {
        let realm = try Realm(configuration: self.configuration())
        try realm.write {
            realm.add(object, update: true)
        }
    }
    
    public static func write(@noescape block: (Self) throws -> Void) throws {
        self.init()
        
        self.willWrite()
        
        defer {
            self.didWrite()
        }
        
        let realm = try Realm(configuration: self.configuration())
        if let object = realm.objectForPrimaryKey(self, key: primaryKeyValue) {
            
            realm.beginWrite()
            
            do {
                try block(object)
            } catch {
                realm.cancelWrite()
                throw error
            }
            
            try realm.commitWrite()
            
        } else {
            
            let object = try self.create(realm)
           
            realm.beginWrite()
            
            do {
                try block(object)
            } catch {
                realm.cancelWrite()
                throw error
            }
            
            try realm.commitWrite()
        }
    }
    
    public static var instance: Self {
        
        let create: () throws -> Self = {
            let realm = try Realm(configuration: self.configuration())
            if let object = realm.objectForPrimaryKey(self, key: primaryKeyValue) {
                return object
            }
            return try self.create(realm)
        }
        
        do {
            return try create()
        } catch {
            
            let error = error as NSError
            if error.code == 10 {
                
                do {
                    try NSFileManager.defaultManager().removeItemAtURL(NSURL(fileURLWithPath: self.filePath()))
                    return try create()
                } catch {
                    fatalError("RealmDefaults Fatal Error: Failed to re-create Realm \(error)")
                }
                
            } else {
            
                fatalError("RealmDefaults Fatal Error: Failed to create Realm \(error)")
            }
        }
    }
    
    private static func create(realm: Realm) throws -> Self {
        let object = self.init()
        try realm.write {
            realm.add(object, update: true)
        }
        return object
    }
}

private let primaryKeyValue = "RealmDefaults"

public class RealmDefaults: RealmSwift.Object, RealmDefaultsType {
    
    public class func purge() {
        self.willPurge()
        defer {
            self.didPurge()
        }
        
        do {
            let realm = try Realm(configuration: self.configuration())
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            // TODO:
        }
    }
    
    public class func schemaVersion() -> UInt64 {
        
        preconditionFailure("Required override this method.")
    }
    
    public class func defaultsName() -> String {
        
        return NSStringFromClass(self)
    }
    
    public class func filePath() -> String {
        
        return documentsPath + "/RealmDefaults_\(self.defaultsName()).realm"
    }
    
    public class func configuration() -> RealmSwift.Realm.Configuration {
       
        return RealmSwift.Realm.Configuration(
            fileURL: NSURL(fileURLWithPath: self.filePath()),
            inMemoryIdentifier: nil,
            encryptionKey: nil,
            readOnly: false,
            schemaVersion: self.schemaVersion(),
            migrationBlock: { (migration, oldSchemaVersion) -> Void in
                self.migration(migration, oldSchemaVersion: oldSchemaVersion)
            },
            objectTypes: [self])
    }
    
    
    // MARK: Object
    public final override class func primaryKey() -> String? {
        return "__identifier"
    }
    
    public class func willWrite() {
        
    }
    
    public class func didWrite() {
        
    }
    
    public class func willPurge() {
        
    }
    
    public class func didPurge() {
        
    }
    
    public class func migration(migration: Migration, oldSchemaVersion: UInt64) {
        
    }
    
    // MARK: Internal
    internal dynamic var __identifier: String = primaryKeyValue

}
