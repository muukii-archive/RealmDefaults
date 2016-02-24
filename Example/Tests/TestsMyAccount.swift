import UIKit
import XCTest
import RealmDefaults

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        MyAccount.purge()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testFirstAccess() {
        
        XCTAssert(MyAccount.instance.name == nil, "")
        XCTAssert(MyAccount.instance.age == 0, "")
        XCTAssert(MyAccount.instance.phoneNumber == nil, "")
    }
    
    func testWrite() {
        
        MyAccount.write { account in
            account.name = "muukii"
            account.age = 25
            account.phoneNumber = "080-0000-0000"
        }
        XCTAssert(MyAccount.instance.name == "muukii", "")
        XCTAssert(MyAccount.instance.age == 25, "")
        XCTAssert(MyAccount.instance.phoneNumber == "080-0000-0000", "")

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }    
}
