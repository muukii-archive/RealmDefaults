//
//  MyAccount.swift
//  RealmDefaults
//
//  Created by Hiroshi Kimura on 2/25/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import RealmDefaults

class MyAccount: RealmDefaults {
    
    dynamic var name: String?
    dynamic var age: Int = 0
    dynamic var phoneNumber: String?
    
    override class func schemaVersion() -> UInt64 {
        return 3
    }
}