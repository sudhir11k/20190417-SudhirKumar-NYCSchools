//
//  NYCSchoolDataProvider.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import Foundation

protocol NYCSchoolDataProviderProtocol {
    func getSchoolDirectory(completionHandler:@escaping(([NYCSchoolDirectoryViewModelProtocol]?, NYCCustomError?)->()))
    func getSchoolSATData(completionHandler:@escaping(([NYCSchoolSATViewModelProtocol]?, NYCCustomError?)->()))
}
class NYCSchoolDataProvider: NYCSchoolDataProviderProtocol {

    var newtorkProvider : NYCSchoolNetworkProviderProtocol?
    var directoryFactoryProvider : NYCSchoolDirectoryFactoryProtocol?
    
    public init(withNetworkProvider networkProvider: NYCSchoolNetworkProviderProtocol = NYCSchoolNetworkProvider(), withFactoryProvider factoryProvider: NYCSchoolDirectoryFactoryProtocol = NYCSchoolDirectoryFactory() ) {
        self.newtorkProvider = networkProvider
        self.directoryFactoryProvider = factoryProvider
    }
    
    func getSchoolDirectory(completionHandler: @escaping((([NYCSchoolDirectoryViewModelProtocol]?, NYCCustomError?) -> ()))) {
        self.newtorkProvider?.callingNYCSchoolServiceApi(NYCSchoolUrl.schoolDirectory.urlPath, completionHandler: { (data, customError, isSuccess) in
            if isSuccess{
                if let data = data{
                    print(data)
                    guard let dataModel = try? JSONDecoder().decode([NYCSchoolDataModel].self, from: data) else{
                        return completionHandler([],NYCCustomError.error(descritption: "Data could not be Parsed"))
                    }
                   let dirVmArray = self.directoryFactoryProvider?.generateDirectoryViewModel(withDataModel: dataModel)
                    
                    completionHandler(dirVmArray, nil)
                    
                }else{
                    completionHandler([],NYCCustomError.error(descritption: "Data could not received or blank"))
                }
                
            }else{
                completionHandler([],NYCCustomError.error(descritption: "ServiceCall Failed"))
            }
        })
        
    }
    
    func getSchoolSATData(completionHandler: @escaping (([NYCSchoolSATViewModelProtocol]?, NYCCustomError?) -> ())) {
        self.newtorkProvider?.callingNYCSchoolServiceApi(NYCSchoolUrl.dataSAT.urlPath, completionHandler: { (data, customError, isSuccess) in
            if isSuccess{
                if let data = data{
                    print(data)
                    guard let dataModel = try? JSONDecoder().decode([NYCSchoolSatDataModal].self, from: data) else{
                        return completionHandler([],NYCCustomError.error(descritption: "Data could not be Parsed"))
                    }
                    let satVmArray = self.directoryFactoryProvider?.generateSATDATAViewModel(withDataModel: dataModel)
                    
                    completionHandler(satVmArray, nil)
                    
                }else{
                    completionHandler([],NYCCustomError.error(descritption: "Data could not received or blank"))
                }
                
            }else{
                completionHandler([],NYCCustomError.error(descritption: "ServiceCall Failed"))
            }
        })
    }
    
}
