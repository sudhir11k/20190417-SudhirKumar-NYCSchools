//
//  NYCSchoolDataProviderTests.swift
//  20190417-SudhirKumar-NYCSchoolsTests
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import XCTest
@testable import _0190417_SudhirKumar_NYCSchools
class NYCSchoolDataProviderTests: XCTestCase {

    var sut : NYCSchoolDataProviderProtocol?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        initiateDataProvider()
    }
    
    func initiateDataProvider(){
        let networkProvider = NYCSchoolNetworkProvider.init()
        let factoryProvider = NYCSchoolDirectoryFactory.init()
        sut = NYCSchoolDataProvider.init(withNetworkProvider: networkProvider, withFactoryProvider : factoryProvider)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetDataFromNetworkCall() {
        
        //sut.getSchoolDirectory(completionHandler:((([Any]?, NYCCustomError?)->())?)
        
        let expectation = self.expectation(description: "After Getting Data from Network, Data Model should be ready")
        var isDataModalReady : Bool?
        var retunedError : NYCCustomError?
        sut?.getSchoolDirectory(completionHandler: { (arrayOfItems, error) in
            isDataModalReady = false
            if arrayOfItems != nil{
                isDataModalReady = true
            }
            retunedError = error
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 20) { (error) in
            print(error?.localizedDescription ?? "Expectation Error - testGetDataFromNetworkCall")
        }
        
        
        if let _ = retunedError {
            XCTFail("Could not returned Data Model")
        }else{
            if let isDataModal_Ready = isDataModalReady {
                isDataModal_Ready ? XCTAssertTrue(isDataModal_Ready, "Data Received") : XCTAssertFalse(isDataModal_Ready, "Data NOT Received")
            }else{
                XCTFail("Could not returned Data Model")
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
