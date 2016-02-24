//
//  TestsArchives.swift
//  RealmDefaults
//
//  Created by Hiroshi Kimura on 2/25/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

class TestsArchives: XCTestCase {

    override func setUp() {
        super.setUp()
        Archives.purge()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSave() {
        
        Archives.write { archives in
            archives.clearStage0 = true
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
