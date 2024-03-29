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
        aPIWithIncorrectURL()
        aPIWithCorrectURL()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func aPIWithIncorrectURL(){
        self.testGetResponseFromAPI(url: "https://data.cityofnewyork11.us/resource/s3k6-pzi2.json")
    }
    
    func aPIWithCorrectURL(){
        self.testGetResponseFromAPI(url: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
    }

    func testGetResponseFromAPI(url:String){
        let urlStr = url
        
        var suceeded : Bool?
        var retunedError : NYCCustomError?
        
        let callbackIsCalled = self.expectation(description: "callingNYCSchoolServiceApi should be called")
        
        sut?.callingNYCSchoolServiceApi(urlStr, completionHandler: { (dataDict, error, isSuccess) in
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
