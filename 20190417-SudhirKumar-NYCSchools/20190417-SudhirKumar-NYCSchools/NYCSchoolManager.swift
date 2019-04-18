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
}

class NYCSchoolManager : NYCSchoolManagerProtocol{
    
    var dataProvider : NYCSchoolDataProviderProtocol?
    var dirctoryVMList : [NYCSchoolDirectoryFactoryProtocol]?
    
    init(withDataProvider dataProvider: NYCSchoolDataProviderProtocol = NYCSchoolDataProvider()) {
        self.dataProvider = dataProvider
    }
    
    func getSchoolDirectoryList(completionHandler: @escaping ([NYCSchoolDirectoryViewModelProtocol]?, NYCCustomError?) -> ()) {
        self.dataProvider?.getSchoolDirectory(completionHandler: { (vmModelList, customError) in
            guard customError == nil else{
                completionHandler(nil, NYCCustomError.error(descritption: "getSchoolDirectoryList returned Error"))
                return
            }
            guard let vmModalList = vmModelList as? [NYCSchoolDirectoryViewModelProtocol]? else {
                completionHandler(nil, NYCCustomError.error(descritption: "View Modal Assignment Error"))
                return
            }
            
            completionHandler(vmModalList, nil)
        })
    }
    
}
