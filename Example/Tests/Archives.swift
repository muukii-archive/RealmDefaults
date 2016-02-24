//
//  Archives.swift
//  RealmDefaults
//
//  Created by Hiroshi Kimura on 2/25/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import RealmDefaults

final class Archives: RealmDefaults {
    
    dynamic var clearStage0: Bool = false
    dynamic var clearStage1: Bool = false
    dynamic var clearStage2: Bool = false
    dynamic var clearStage3: Bool = false
    dynamic var clearStage4: Bool = false
    
    override class func schemaVersion() -> UInt64 {
        return 3
    }
}