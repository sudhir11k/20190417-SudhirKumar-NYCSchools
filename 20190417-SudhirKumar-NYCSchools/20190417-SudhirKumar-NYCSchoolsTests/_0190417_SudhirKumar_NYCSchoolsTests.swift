//
//  _0190417_SudhirKumar_NYCSchoolsTests.swift
//  20190417-SudhirKumar-NYCSchoolsTests
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import XCTest
@testable import _0190417_SudhirKumar_NYCSchools

class _0190417_SudhirKumar_NYCSchoolsTests: XCTestCase {
    
    var sut_ViewController : NYCSchoolHomeViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        guard let viewcontroller = UIStoryboard(name: "Main", bundle: Bundle(for: NYCSchoolHomeViewController.self)).instantiateViewController(withIdentifier: "NYCSchoolHomeViewControllerID") as? NYCSchoolHomeViewController else{
            return
        }
        
        sut_ViewController = viewcontroller
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataProviderExistance(){
        
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
