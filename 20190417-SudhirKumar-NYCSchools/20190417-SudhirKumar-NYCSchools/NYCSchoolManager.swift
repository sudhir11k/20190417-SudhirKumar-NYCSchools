//
//  NYCSchoolManager.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import Foundation

protocol NYCSchoolManagerProtocol {
    func getSchoolDirectoryList(completionHandler : @escaping ([NYCSchoolDirectoryViewModelProtocol]?, NYCCustomError?) -> ())
    func getSatDataList(completionHandler : @escaping ([NYCSchoolSATViewModelProtocol
        ]?, NYCCustomError?) -> ())
}

class NYCSchoolManager : NYCSchoolManagerProtocol{

    var dataProvider : NYCSchoolDataProviderProtocol?
    var dirctoryVMList : [NYCSchoolDirectoryFactoryProtocol]?
    var dataSource : NYCSchoolDiretoryDataSource?
    
    init(withDataProvider dataProvider: NYCSchoolDataProviderProtocol = NYCSchoolDataProvider(), withDataSource dataSource :NYCSchoolDiretoryDataSource = NYCSchoolDiretoryDataSource() ) {
        self.dataProvider = dataProvider
        self.dataSource = dataSource
    }

    
    /// getSchoolDirectoryList - To return the callback handler with ViewModal array to caller
    ///
    /// - Parameter completionHandler: it will have [NYCSchoolDirectoryViewModelProtocol] or error at time
    func getSchoolDirectoryList(completionHandler: @escaping ([NYCSchoolDirectoryViewModelProtocol]?, NYCCustomError?) -> ()) {
        self.dataProvider?.getSchoolDirectory(completionHandler: { (vmModelList, customError) in
            guard customError == nil else{
                completionHandler(nil, NYCCustomError.error(descritption: "getSchoolDirectoryList returned Error"))
                return
            }
            guard let vmModal_List = vmModelList as? [NYCSchoolDirectoryViewModelProtocol]?, (vmModal_List?.count ?? 0) > 0 else {
                completionHandler(nil, NYCCustomError.error(descritption: "View Modal Assignment Error"))
                return
            }
            completionHandler(vmModal_List,nil)
        })
    }
    
    /// getSatDataList - To return the callback handler with ViewModal array to caller
    ///
    /// - Parameter completionHandler: it will have [NYCSchoolSATViewModelProtocol] or error at time
    func getSatDataList(completionHandler: @escaping ([NYCSchoolSATViewModelProtocol]?, NYCCustomError?) -> ()) {
        self.dataProvider?.getSchoolSATData(completionHandler: { (satVmList, error) in
            guard error == nil else{
                completionHandler(nil, NYCCustomError.error(descritption: "getSatDataList returned Error"))
                return
            }
            guard let satVm_List = satVmList as? [NYCSchoolSATViewModelProtocol]?, (satVmList?.count ?? 0) > 0 else {
                completionHandler(nil, NYCCustomError.error(descritption: "View Modal Assignment Error"))
                return
            }
            completionHandler(satVm_List,nil)
        })
    }
    
    /// getSatDataList - To return the Data Source for the UITableView
    ///
    /// - Parameter completionHandler: it will have [NYCSchoolDirectoryViewModelProtocol] or error at time
    func getDataSourceForTableView(withDirectoryVMList vmList:[NYCSchoolDirectoryViewModelProtocol], withSATVMList satDataVMList: [NYCSchoolSATViewModelProtocol], completionHandler : @escaping (NYCSchoolDiretoryDataSource?, NYCCustomError?) -> ()){
        self.dataSource?.directoryVMList = vmList
        self.dataSource?.satDataVMList = satDataVMList
        completionHandler(self.dataSource, nil)
    }
    
}
