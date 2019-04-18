//
//  NYCSchoolManagerTests.swift
//  20190417-SudhirKumar-NYCSchoolsTests
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import XCTest

@testable import _0190417_SudhirKumar_NYCSchools

class NYCSchoolManagerTests: XCTestCase {

    var sut : NYCSchoolManager?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let networkProvider = NYCSchoolNetworkProvider.init()
        let factoryProvider = NYCSchoolDirectoryFactory.init()
        let dataProvider = NYCSchoolDataProvider.init(withNetworkProvider: networkProvider, withFactoryProvider : factoryProvider)
    
        sut = NYCSchoolManager.init(withDataProvider:dataProvider)
    
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getSchoolDirectoryList()  {
        
        
        let expectation_GetDirVMList = self.expectation(description: "Manager should have Directory View Modal Array")
        
        var testError : NYCCustomError?
        var isManagerHasViewModal : Bool?
        
        sut?.getSchoolDirectoryList(completionHandler: { (directoryVmList, customError) in
            testError = customError
            
            if directoryVmList != nil {
                isManagerHasViewModal = true
            }
            expectation_GetDirVMList.fulfill()
        })
        
        waitForExpectations(timeout: 20, handler: nil)
        
        if (testError != nil) {
            XCTAssert(testError != nil, testError?.localizedDescription ?? "Error test_getSchoolDirectoryList")
        }else{
            if let isManagerHasViewModal = isManagerHasViewModal{
                isManagerHasViewModal ? XCTAssertTrue(isManagerHasViewModal, "View Modal has been created") : XCTAssertFalse(isManagerHasViewModal, "View Modal has not been created")
            }
        }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
