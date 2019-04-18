//
//  NYCSchoolDirectoryFactoryTests.swift
//  20190417-SudhirKumar-NYCSchoolsTests
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import XCTest
@testable import _0190417_SudhirKumar_NYCSchools
class NYCSchoolDirectoryFactoryTests: XCTestCase {
    
    var sut : NYCSchoolDirectoryFactory?
    var helperDataProvider : NYCSchoolDataProviderTests?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = NYCSchoolDirectoryFactory()
        helperDataProvider = NYCSchoolDataProviderTests()
        helperDataProvider?.setUp()
        
        //helperDataProvider = NYCSchoolDataProviderTests.initiateDataProvider(<#T##NYCSchoolDataProviderTests#>)
        
    }
    
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_GenerateViewModel(){
        
        let expectation_creationOfViewModel = self.expectation(description: "Array of View Model Should be ready ")
        var isViewModelDataCreated : Bool?
        var testError : NYCCustomError?
        helperDataProvider?.sut?.getSchoolDirectory(completionHandler: { (dataModelArray, error) in
            testError = error
            if testError == nil{
                if let dataModel_Array = dataModelArray as? [NYCSchoolDataModel]{
                    let dirViewModalArray = self.sut?.generateDirectoryViewModel(withDataModel: dataModel_Array)
                    dirViewModalArray?.count ?? 0 > 0 ? (isViewModelDataCreated = true) : (isViewModelDataCreated = false)
                }
            }
            expectation_creationOfViewModel.fulfill()
        })
        
        waitForExpectations(timeout: 30, handler: nil)
        
        if testError != nil{
            XCTFail("test_GenerateViewModel recevied Custom error while parsing")
        }else{
            if let isViewModelDataCreated = isViewModelDataCreated{
                isViewModelDataCreated ? XCTAssertTrue(isViewModelDataCreated, "View Modal has been created") : XCTAssertFalse(isViewModelDataCreated, "View Modal has not been created")
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
