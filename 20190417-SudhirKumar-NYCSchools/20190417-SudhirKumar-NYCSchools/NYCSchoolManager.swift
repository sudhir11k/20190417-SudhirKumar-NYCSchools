//
//  NYCSchoolManager.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import Foundation

protocol NYCSchoolManagerProtocol {
    func getSchoolDirectoryList(completionHandler : @escaping (NYCSchoolDiretoryDataSource?, NYCCustomError?) -> ())
}

class NYCSchoolManager : NYCSchoolManagerProtocol{
    
    var dataProvider : NYCSchoolDataProviderProtocol?
    var dirctoryVMList : [NYCSchoolDirectoryFactoryProtocol]?
    
    var dataSource : NYCSchoolDiretoryDataSource?
    
    init(withDataProvider dataProvider: NYCSchoolDataProviderProtocol = NYCSchoolDataProvider(), withDataSource dataSource :NYCSchoolDiretoryDataSource = NYCSchoolDiretoryDataSource() ) {
        self.dataProvider = dataProvider
        self.dataSource = dataSource
    }
    
    func getSchoolDirectoryList(completionHandler: @escaping (NYCSchoolDiretoryDataSource?, NYCCustomError?) -> ()) {
        self.dataProvider?.getSchoolDirectory(completionHandler: { (vmModelList, customError) in
            guard customError == nil else{
                completionHandler(nil, NYCCustomError.error(descritption: "getSchoolDirectoryList returned Error"))
                return
            }
            guard let vmModal_List = vmModelList as? [NYCSchoolDirectoryViewModelProtocol]?, (vmModal_List?.count ?? 0) > 0 else {
                completionHandler(nil, NYCCustomError.error(descritption: "View Modal Assignment Error"))
                return
            }
        
            self.getDataSourceForTableView(withVMList: vmModal_List ?? [], completionHandler: completionHandler)
        })
    }
    
    func getDataSourceForTableView(withVMList vmList:[NYCSchoolDirectoryViewModelProtocol], completionHandler : @escaping (NYCSchoolDiretoryDataSource?, NYCCustomError?) -> ()){
        
        self.dataSource?.directoryVMList = vmList
        completionHandler(self.dataSource, nil)
    }
    
}
