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
            //self.getDataSourceForTableView(withVMList: vmModal_List ?? [], completionHandler: completionHandler)
        })
    }
    
    
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
    
    
    func getDataSourceForTableView(withDirectoryVMList vmList:[NYCSchoolDirectoryViewModelProtocol], withSATVMList satDataVMList: [NYCSchoolSATViewModelProtocol], completionHandler : @escaping (NYCSchoolDiretoryDataSource?, NYCCustomError?) -> ()){
        self.dataSource?.directoryVMList = vmList
        self.dataSource?.satDataVMList = satDataVMList
        completionHandler(self.dataSource, nil)
    }
    
}
