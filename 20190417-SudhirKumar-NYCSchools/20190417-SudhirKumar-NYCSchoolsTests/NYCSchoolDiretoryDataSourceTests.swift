//
//  NYCSchoolDiretoryDataSourceTests.swift
//  20190417-SudhirKumar-NYCSchoolsTests
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import XCTest
@testable import _0190417_SudhirKumar_NYCSchools

class NYCSchoolDiretoryDataSourceTests: XCTestCase {
    var sut : NYCSchoolDiretoryDataSource?
    var tableView : MockTableView?
    var helperNYCManager : NYCSchoolManagerTests?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.helperNYCManager = NYCSchoolManagerTests()
        self.helperNYCManager?.setUp()
        let expectationSetup = self.expectation(description: "NYCSchoolDiretoryDataSourceTests setUp")
        self.helperNYCManager?.sut?.getSchoolDirectoryList(completionHandler: { (dataSource, customError) in
            self.sut = dataSource
            if let dataSource = self.sut{
                DispatchQueue.main.sync {
                     self.tableView = (MockTableView.mockTableView(withDataSource: dataSource) as! NYCSchoolDiretoryDataSourceTests.MockTableView)
                    self.tableView?.reloadData()
                    
                }
               
            }
            expectationSetup.fulfill()
        })
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func test_NumberOfSection(){
        XCTAssertEqual(self.tableView?.numberOfSections, 1)
    }
    
    func test_NumberOfRowsInsection(){
        XCTAssertEqual(self.tableView?.numberOfRows(inSection: 0), sut?.directoryVMList?.count ?? 0)
    }
    
    
    func test_DirectoryCell(){
        if sut?.directoryVMList?.count ?? 0 > 0{
            let firstVm =  sut?.directoryVMList?.first
            if let cell = self.tableView?.cellForRow(at: IndexPath(row: 0, section: 0)) as? UITableViewCell{
                XCTAssertEqual(cell.textLabel?.text, firstVm?.school_name)
            }
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


extension NYCSchoolDiretoryDataSourceTests {
    class MockTableView: UITableView {
        
        override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
            return super.dequeueReusableCell(withIdentifier: identifier)
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableView(withDataSource dataSource: NYCSchoolDiretoryDataSource) -> UITableView{
            
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 400), style: UITableView.Style.plain)
            mockTableView.dataSource = dataSource
            mockTableView.register(UITableViewCell.self, forCellReuseIdentifier: "NYCSchoolDirectoryCellIdentifier")
            
            return mockTableView
        }
    }
}
