//
//  NYCSchoolDirectoryFactory.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import Foundation

protocol NYCSchoolDirectoryViewModelProtocol{
    var school_name : String {get}
}

struct NYCSchoolDirectoryVM : NYCSchoolDirectoryViewModelProtocol{
    var school_name : String
    
    init(withDirectoryModel directory: NYCSchoolDataModel) {
        self.school_name = directory.school_name ?? "School Name- N/A"
    }
}

protocol NYCSchoolDirectoryFactoryProtocol {
    
    func generateDirectoryViewModel(withDataModel dataModel: [NYCSchoolDataModel]) -> [NYCSchoolDirectoryViewModelProtocol]
}


class NYCSchoolDirectoryFactory : NYCSchoolDirectoryFactoryProtocol{
    
    func generateDirectoryViewModel(withDataModel dataModel: [NYCSchoolDataModel]) -> [NYCSchoolDirectoryViewModelProtocol] {
        
        var directoryViewModalArr : [NYCSchoolDirectoryViewModelProtocol] = []
        for schoolDataModel in dataModel {
            let dir_viewModal = NYCSchoolDirectoryVM(withDirectoryModel: schoolDataModel as! NYCSchoolDataModel)
            directoryViewModalArr.append(dir_viewModal)
        }
        
        return directoryViewModalArr
    }
}
