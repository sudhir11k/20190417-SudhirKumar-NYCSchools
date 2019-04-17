//
//  NYCSchoolNetworkProviderTests.swift
//  20190417-SudhirKumar-NYCSchoolsTests
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import XCTest
@testable import _0190417_SudhirKumar_NYCSchools
class NYCSchoolNetworkProviderTests: XCTestCase {
    
    var sut : NYCSchoolNetworkProvider?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = NYCSchoolNetworkProvider()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetResponseFromAPI(){
        let urlStr = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        
        var suceeded : Bool?
        var retunedError : NYCCustomError?
        
        let callbackIsCalled = self.expectation(description: "callingNYCSchoolServiceApi should be called")
        
        sut?.callingNYCSchoolServiceApi(urlStr, completionHandler: { (data, error, isSuccess) in
            suceeded = isSuccess
            retunedError = error
            callbackIsCalled.fulfill()
        })
        
        waitForExpectations(timeout: 20) { (error) in
            print(error?.localizedDescription ?? "Test Exception Error")
        }
        
        guard let successVal = suceeded else{
            XCTFail("callingNYCSchoolServiceApi has not returned before time out")
            return
        }
        
        if retunedError == nil{
            XCTAssert(successVal == true, "Service Call suceeded")
        }else{
             XCTAssert(successVal == false, "Service Call Failed")
        }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
